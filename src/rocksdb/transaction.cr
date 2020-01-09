require "../librocksdb"
require "./options"

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

    abstract def finalize

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

    def iterator(read_options : ReadOptions = @default_read_options)
      Iterator.new(LibRocksDB.transaction_create_iterator(self, read_options))
    end
  end
end
