lib LibRocksDB
  struct Transaction
    dummy : UInt8
  end

  fun transaction_commit = rocksdb_transaction_commit(txn : Transaction*, errptr : UInt8**)
  fun transaction_rollback = rocksdb_transaction_rollback(txn : Transaction*, errptr : UInt8**)
  fun transaction_set_savepoint = rocksdb_transaction_set_savepoint(txn : Transaction*)
  fun transaction_rollback_to_savepoint = rocksdb_transaction_rollback_to_savepoint(txn : Transaction*, errptr : UInt8**)
  fun transaction_destroy = rocksdb_transaction_destroy(txn : Transaction*)
  fun transaction_get = rocksdb_transaction_get(txn : Transaction*, read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : UInt8**) : UInt8*
  fun transaction_get_for_update = rocksdb_transaction_get_for_update(txn : Transaction*, read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT, vallen : LibC::SizeT*, exclusive : UInt8, errptr : UInt8**) : UInt8*
  fun transaction_put = rocksdb_transaction_put(txn : Transaction*, key : UInt8*, keylen : LibC::SizeT, val : UInt8*, vallen : LibC::SizeT, errptr : UInt8**)
  fun transaction_delete = rocksdb_transaction_delete(txn : Transaction*, key : UInt8*, keylen : LibC::SizeT, errptr : UInt8**)
  fun transaction_write = rocksdb_transaction_write(txn : Transaction*, batch : WriteBatch*, errptr : UInt8**)
end

module RocksDB
  abstract class BaseTransaction
    @value : LibRocksDB::Transaction*
    @default_read_options : ReadOptions
    @default_write_options : WriteOptions

    def to_unsafe
      @value
    end

    def initialize(@value : LibRocksDB::Transaction*, @default_read_options : ReadOptions, @default_write_options : WriteOptions)
    end

    def finalize
      LibRocksDB.transaction_destroy(self)
    end

    def commit
      RocksDB.err_check { |err| LibRocksDB.transaction_commit(self, err) }
    end

    def rollback
      RocksDB.err_check { |err| LibRocksDB.transaction_rollback(self, err) }
    end

    def set_savepoint
      LibRocksDB.rocksdb_transaction_set_savepoint(self)
    end

    def rollback_to_savepoint
      RocksDB.err_check { |err| LibRocksDB.transaction_rollback_to_savepoint(self, err) }
    end

    def get(key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      len = uninitialized LibC::SizeT
      ptr = RocksDB.err_check do |err|
        LibRocksDB.transaction_get(self, read_options, key, key.size, pointerof(len), err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def get_for_update(key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      len = uninitialized LibC::SizeT
      ptr = RocksDB.err_check do |err|
        LibRocksDB.transaction_get_for_update(self, read_options, key, key.size, pointerof(len), 1, err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def put(key : Bytes, value : Bytes)
      RocksDB.err_check do |err|
        LibRocksDB.transaction_put(self, key, key.size, value, value.size, err)
      end
    end

    def delete(key : Bytes)
      RocksDB.err_check do |err|
        LibRocksDB.transaction_delete(self, key, key.size, err)
      end
    end

    def write(batch : WriteBatch)
      RocksDB.err_check do |err|
        LibRocksDB.transaction_write(self, batch, err)
      end
    end
  end
end
