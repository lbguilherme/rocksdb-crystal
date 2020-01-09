require "./transaction"
require "./db"
require "./options"
require "../librocksdb"

module RocksDB
  class OptimisticTransactionDatabase < Database
    def self.open(path : String, options : Options) : OptimisticTransactionDatabase
      optimistic_transaction_db = RocksDB.err_check do |err|
        LibRocksDB.optimistictransactiondb_open(options, path, err)
      end
      new(LibRocksDB.optimistictransactiondb_get_base_db(optimistic_transaction_db), optimistic_transaction_db)
    end

    def initialize(value, @optimistic_transaction_db : LibRocksDB::OptimisticTransactionDb*)
      super(value)
      @default_optimistic_transaction_options = OptimisticTransactionOptions.new
    end

    def close
      return if closed?
      LibRocksDB.optimistictransactiondb_close_base_db(@value)
      LibRocksDB.optimistictransactiondb_close(@optimistic_transaction_db)
      @value = Pointer(LibRocksDB::Db).null
      @optimistic_transaction_db = Pointer(LibRocksDB::OptimisticTransactionDb).null
    end

    def begin_transaction(write_options : WriteOptions = @default_write_options, optimistic_transaction_options : OptimisticTransactionOptions = @default_optimistic_transaction_options)
      raise ClosedDatabaseError.new if closed?
      OptimisticTransaction.new(
        LibRocksDB.optimistictransaction_begin(@optimistic_transaction_db, write_options, optimistic_transaction_options, nil),
        @default_read_options,
        @default_write_options,
        @default_optimistic_transaction_options,
        self
      )
    end

    def begin_transaction(old : OptimisticTransaction, write_options : WriteOptions = @default_write_options, optimistic_transaction_options : OptimisticTransactionOptions = @default_optimistic_transaction_options)
      raise ClosedDatabaseError.new if closed?
      LibRocksDB.optimistictransaction_begin(@optimistic_transaction_db, write_options, optimistic_transaction_options, old)
    end
  end

  class OptimisticTransaction < BaseTransaction
    @default_optimistic_transaction_options : OptimisticTransactionOptions
    @optimistic_transaction_db : OptimisticTransactionDatabase

    def initialize(value, default_read_options, default_write_options, @default_optimistic_transaction_options : OptimisticTransactionOptions, @optimistic_transaction_db : OptimisticTransactionDatabase)
      super(value, default_read_options, default_write_options)
    end

    def begin(write_options : WriteOptions = @default_write_options, optimistic_transaction_options : OptimisticTransactionOptions = @default_optimistic_transaction_options)
      @optimistic_transaction_db.begin_transaction(self, write_options, optimistic_transaction_options)
    end

    def finalize
      LibRocksDB.transaction_destroy(self) unless @optimistic_transaction_db.closed?
    end
  end

  class OptimisticTransactionOptions
    def initialize
      @value = LibRocksDB.optimistictransaction_options_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.optimistictransaction_options_destroy(self)
    end

    def set_snapshot=(value : Bool)
      LibRocksDB.optimistictransaction_options_set_set_snapshot(self, value ? 1 : 0)
    end
  end
end
