require "./transaction"
require "./db"
require "./options"
require "../librocksdb"

module RocksDB
  class OptimisticTransactionDatabase < Database
    def self.open(path : String, options : Options)
      optimistic_transaction_db = RocksDB.err_check do |err|
        LibRocksDB.optimistictransactiondb_open(options, path, err)
      end
      db = LibRocksDB.optimistictransactiondb_get_base_db(optimistic_transaction_db)
      new(db, optimistic_transaction_db)
    end

    def self.open(path : String, options : Options, families : Hash(String, Options))
      names = families.keys
      family_names = names.map(&.to_unsafe).to_unsafe
      family_options = names.map { |name| families[name].to_unsafe }.to_unsafe
      handles = Pointer(LibRocksDB::ColumnFamilyHandle*).malloc(names.size)
      optimistic_transaction_db = RocksDB.err_check do |err|
        LibRocksDB.optimistictransactiondb_open_column_families(options, path, families.size, family_names, family_options, handles, err)
      end
      handle_table = names.map_with_index { |name, i| {name, ColumnFamilyHandle.new(handles[i])} }.to_h
      db = LibRocksDB.optimistictransactiondb_get_base_db(optimistic_transaction_db)
      new(db, optimistic_transaction_db, handle_table)
    end

    def initialize(value, @optimistic_transaction_db : LibRocksDB::OptimisticTransactionDb*, families = {} of String => ColumnFamilyHandle)
      super(value, families)
      @default_optimistic_transaction_options = OptimisticTransactionOptions.new
    end

    def close
      return if closed?
      @families.values.each do |cf|
        LibRocksDB.column_family_handle_destroy(cf)
      end
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
