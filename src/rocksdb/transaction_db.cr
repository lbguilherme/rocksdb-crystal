require "./transaction"

lib LibRocksDB
  struct TransactionDb
    dummy : UInt8
  end

  fun transactiondb_open = rocksdb_transactiondb_open(options : Options*, transactiondb_options : TransactionDbOptions*, name : UInt8*, errptr : UInt8**) : TransactionDb*
  fun transactiondb_close = rocksdb_transactiondb_close(transactiondb : TransactionDb*)
  fun transactiondb_get = rocksdb_transactiondb_get(transactiondb : TransactionDb*, read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : UInt8**) : UInt8*
  fun transactiondb_put = rocksdb_transactiondb_put(transactiondb : TransactionDb*, write_options : WriteOptions*, key : UInt8*, keylen : LibC::SizeT, val : UInt8*, vallen : LibC::SizeT, errptr : UInt8**)
  fun transactiondb_delete = rocksdb_transactiondb_delete(transactiondb : TransactionDb*, write_options : WriteOptions*, key : UInt8*, keylen : LibC::SizeT, errptr : UInt8**)
  fun transactiondb_write = rocksdb_transactiondb_write(transactiondb : TransactionDb*, write_options : WriteOptions*, batch : WriteBatch*, errptr : UInt8**)
  fun transactiondb_create_iterator = rocksdb_transactiondb_create_iterator(transactiondb : TransactionDb*, read_options : ReadOptions*) : Iterator*

  struct TransactionDbOptions
    dummy : UInt8
  end

  fun transactiondb_options_create = rocksdb_transactiondb_options_create : TransactionDbOptions*
  fun transactiondb_options_destroy = rocksdb_transactiondb_options_destroy(transactiondb_options : TransactionDbOptions*)
  fun transactiondb_options_set_max_num_locks = rocksdb_transactiondb_options_set_max_num_locks(transactiondb_options : TransactionDbOptions*, value : Int64)
  fun transactiondb_options_set_num_stripes = rocksdb_transactiondb_options_set_num_stripes(transactiondb_options : TransactionDbOptions*, value : LibC::SizeT)
  fun transactiondb_options_set_transaction_lock_timeout = rocksdb_transactiondb_options_set_transaction_lock_timeout(transactiondb_options : TransactionDbOptions*, value : Int64)
  fun transactiondb_options_set_default_lock_timeout = rocksdb_transactiondb_options_set_default_lock_timeout(transactiondb_options : TransactionDbOptions*, value : Int64)

  struct TransactionOptions
    dummy : UInt8
  end

  fun transaction_options_create = rocksdb_transaction_options_create : TransactionOptions*
  fun transaction_options_destroy = rocksdb_transaction_options_destroy(transaction_options : TransactionOptions*)
  fun transaction_options_set_set_snapshot = rocksdb_transaction_options_set_set_snapshot(transaction_options : TransactionOptions*, value : UInt8)
  fun transaction_options_set_deadlock_detect = rocksdb_transaction_options_set_deadlock_detect(transaction_options : TransactionOptions*, value : UInt8)
  fun transaction_options_set_lock_timeout = rocksdb_transaction_options_set_lock_timeout(transaction_options : TransactionOptions*, lock_timeout : Int64)
  fun transaction_options_set_expiration = rocksdb_transaction_options_set_expiration(transaction_options : TransactionOptions*, expiration : Int64)
  fun transaction_options_set_deadlock_detect_depth = rocksdb_transaction_options_set_deadlock_detect_depth(transaction_options : TransactionOptions*, depth : Int64)
  fun transaction_options_set_max_write_batch_size = rocksdb_transaction_options_set_max_write_batch_size(transaction_options : TransactionOptions*, size : LibC::SizeT)

  fun transaction_begin = rocksdb_transaction_begin(transactiondb : TransactionDb*, write_options : WriteOptions*, txn_options : TransactionOptions*, old_txn : Transaction*) : Transaction*
end

module RocksDB
  class TransactionDatabase < Database
    def self.open(path : String, options : Options, txn_options : TransactionDatabaseOptions = TransactionDatabaseOptions.new) : TransactionDatabase
      transaction_db = RocksDB.err_check do |err|
        LibRocksDB.transactiondb_open(options, txn_options, path, err)
      end
      new(transaction_db)
    end

    def to_unsafe
      @transaction_db
    end

    def initialize(@transaction_db : LibRocksDB::TransactionDb*)
      super(Pointer(LibRocksDB::Db).null)
      @default_transaction_options = TransactionOptions.new
    end

    def finalize
      close unless @transaction_db.null?
    end

    def close
      LibRocksDB.transactiondb_close(@transaction_db)
      @transaction_db = Pointer(LibRocksDB::TransactionDb).null
    end

    def begin_transaction(write_options : WriteOptions = @default_write_options, transaction_options : TransactionOptions = @default_transaction_options)
      raise ClosedDatabaseError.new if @transaction_db.null?
      Transaction.new(
        LibRocksDB.transaction_begin(@transaction_db, write_options, transaction_options, nil),
        @default_read_options,
        @default_write_options,
        @default_transaction_options,
        self
      )
    end

    def begin_transaction(old : Transaction, write_options : WriteOptions = @default_write_options, transaction_options : TransactionOptions = @default_transaction_options)
      raise ClosedDatabaseError.new if @transaction_db.null?
      LibRocksDB.transaction_begin(@transaction_db, write_options, transaction_options, old)
    end

    def get(key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      raise ClosedDatabaseError.new if @transaction_db.null?
      len = uninitialized LibC::SizeT
      ptr = RocksDB.err_check do |err|
        LibRocksDB.transactiondb_get(self, read_options, key, key.size, pointerof(len), err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def put(key : Bytes, value : Bytes, write_options : WriteOptions = @default_write_options)
      raise ClosedDatabaseError.new if @transaction_db.null?
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_put(self, write_options, key, key.size, value, value.size, err)
      end
    end

    def delete(key : Bytes, write_options : WriteOptions = @default_write_options)
      raise ClosedDatabaseError.new if @transaction_db.null?
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_delete(self, write_options, key, key.size, err)
      end
    end

    def write(batch : WriteBatch, write_options : WriteOptions = @default_write_options)
      raise ClosedDatabaseError.new if @transaction_db.null?
      RocksDB.err_check do |err|
        LibRocksDB.transactiondb_write(self, write_options, batch, err)
      end
    end

    def iterator(read_options : ReadOptions = @default_read_options)
      raise ClosedDatabaseError.new if @transaction_db.null?
      Iterator.new(LibRocksDB.transactiondb_create_iterator(self, read_options))
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
