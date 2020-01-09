require "./transaction"
require "./snapshot"
require "./db"
require "../librocksdb"

module RocksDB
  class TransactionDatabase
    def self.open(path : String, options : Options, txn_options : TransactionDatabaseOptions = TransactionDatabaseOptions.new) : TransactionDatabase
      transaction_db = RocksDB.err_check do |err|
        LibRocksDB.transactiondb_open(options, txn_options, path, err)
      end
      new(transaction_db)
    end

    def self.open(path : String, options : Options, families : Hash(String, Options), txn_options : TransactionDatabaseOptions = TransactionDatabaseOptions.new)
      names = families.keys
      family_names = names.map(&.to_unsafe).to_unsafe
      family_options = names.map { |name| families[name].to_unsafe }.to_unsafe
      handles = Pointer(LibRocksDB::ColumnFamilyHandle*).malloc(names.size)
      transaction_db = RocksDB.err_check do |err|
        LibRocksDB.transactiondb_open_column_families(options, txn_options, path, families.size, family_names, family_options, handles, err)
      end
      handle_table = names.map_with_index { |name, i| {name, ColumnFamilyHandle.new(handles[i])} }.to_h
      new(transaction_db, handle_table)
    end

    def to_unsafe
      @value
    end

    def initialize(@value : LibRocksDB::TransactionDb*, @families = {} of String => ColumnFamilyHandle)
      @default_read_options = ReadOptions.new
      @default_write_options = WriteOptions.new
      @default_transaction_options = TransactionOptions.new
    end

    def finalize
      close
    end

    def closed?
      @value.null?
    end

    def close
      return if closed?
      @families.values.each do |cf|
        LibRocksDB.column_family_handle_destroy(cf)
      end
      LibRocksDB.transactiondb_close(@value)
      @value = Pointer(LibRocksDB::TransactionDb).null
    end

    def family_handle(name : String)
      @families[name]
    end

    def family_handle?(name : String)
      @families[name]?
    end

    def create_column_family(name : String, options : Options)
      @families[name] = ColumnFamilyHandle.new(RocksDB.err_check do |err|
        LibRocksDB.transactiondb_create_column_family(self, options, name, err)
      end)
    end

    def drop_column_family(name : String) : Nil
      handle = @families[name]
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_drop_column_family(self, handle, err)
      end
      @families.delete(name)
    end

    def begin_transaction(write_options : WriteOptions = @default_write_options, transaction_options : TransactionOptions = @default_transaction_options)
      raise ClosedDatabaseError.new if closed?
      Transaction.new(
        LibRocksDB.transaction_begin(self, write_options, transaction_options, nil),
        @default_read_options,
        @default_write_options,
        @default_transaction_options,
        self
      )
    end

    def begin_transaction(old : Transaction, write_options : WriteOptions = @default_write_options, transaction_options : TransactionOptions = @default_transaction_options)
      raise ClosedDatabaseError.new if closed?
      LibRocksDB.transaction_begin(self, write_options, transaction_options, old)
    end

    def get(key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      raise ClosedDatabaseError.new if closed?
      len = uninitialized LibC::SizeT
      ptr = RocksDB.err_check do |err|
        LibRocksDB.transactiondb_get(self, read_options, key, key.size, pointerof(len), err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def get(column_family : ColumnFamilyHandle, key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      raise ClosedDatabaseError.new if closed?
      len = uninitialized LibC::SizeT
      ptr = RocksDB.err_check do |err|
        LibRocksDB.transactiondb_get_cf(self, read_options, column_family, key, key.size, pointerof(len), err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def put(key : Bytes, value : Bytes, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_put(self, write_options, key, key.size, value, value.size, err)
      end
    end

    def put(column_family : ColumnFamilyHandle, key : Bytes, value : Bytes, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_put_cf(self, write_options, column_family, key, key.size, value, value.size, err)
      end
    end

    def delete(key : Bytes, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_delete(self, write_options, key, key.size, err)
      end
    end

    def delete(column_family : ColumnFamilyHandle, key : Bytes, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_delete_cf(self, write_options, column_family, key, key.size, err)
      end
    end

    def write(batch : WriteBatch, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_write(self, write_options, batch, err)
      end
    end

    def iterator(read_options : ReadOptions = @default_read_options)
      raise ClosedDatabaseError.new if closed?
      Iterator.new(LibRocksDB.transactiondb_create_iterator(self, read_options), self)
    end

    def snapshot
      raise ClosedDatabaseError.new if closed?
      Snapshot.new(LibRocksDB.transactiondb_create_snapshot(self), self)
    end

    class Snapshot < BaseSnapshot
      def initialize(snapshot : LibRocksDB::Snapshot*, @db : TransactionDatabase)
        super(snapshot)
      end

      def finalize
        LibRocksDB.transactiondb_release_snapshot(@db, self) unless @db.to_unsafe.null?
      end
    end
  end

  class Transaction < BaseTransaction
    @default_transaction_options : TransactionOptions
    @transaction_db : TransactionDatabase

    def initialize(value, default_read_options, default_write_options, @default_transaction_options : TransactionOptions, @transaction_db : TransactionDatabase)
      super(value, default_read_options, default_write_options)
    end

    def begin(write_options : WriteOptions = @default_write_options, transaction_options : TransactionOptions = @default_transaction_options)
      @transaction_db.begin_transaction(self, write_options, transaction_options)
    end

    def finalize
      LibRocksDB.transaction_destroy(self) unless @transaction_db.closed?
    end
  end

  class TransactionDatabaseOptions
    def initialize
      @value = LibRocksDB.transactiondb_options_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.transactiondb_options_destroy(self)
    end

    def max_num_locks=(value : Int)
      LibRocksDB.transactiondb_options_set_max_num_locks(self, value)
    end

    def num_stripes=(value : Int)
      LibRocksDB.transactiondb_options_set_num_stripes(self, value)
    end

    def transaction_lock_timeout=(value : Int)
      LibRocksDB.transactiondb_options_set_transaction_lock_timeout(self, value)
    end

    def default_lock_timeout=(value : Int)
      LibRocksDB.transactiondb_options_set_default_lock_timeout(self, value)
    end
  end

  class TransactionOptions
    def initialize
      @value = LibRocksDB.transaction_options_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.transaction_options_destroy(self)
    end

    def set_snapshot=(value : Bool)
      LibRocksDB.transaction_options_set_set_snapshot(self, value ? 1 : 0)
    end

    def deadlock_detect=(value : Int)
      LibRocksDB.transaction_options_set_deadlock_detect(self, value)
    end

    def lock_timeout=(value : Int)
      LibRocksDB.transaction_options_set_lock_timeout(self, value)
    end

    def expiration=(value : Int)
      LibRocksDB.transaction_options_set_expiration(self, value)
    end

    def deadlock_detect_depth=(value : Int)
      LibRocksDB.transaction_options_set_deadlock_detect_depth(self, value)
    end

    def max_write_batch_size=(value : Int)
      LibRocksDB.transaction_options_set_max_write_batch_size(self, value)
    end
  end
end
