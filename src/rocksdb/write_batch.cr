require "../librocksdb"

module RocksDB
  class WriteBatch
    def initialize
      @value = LibRocksDB.writebatch_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.writebatch_destroy(self)
    end

    def clear
      LibRocksDB.writebatch_clear(self)
    end

    def count
      LibRocksDB.writebatch_count(self)
    end

    def put(key : Bytes, value : Bytes) : Nil
      LibRocksDB.writebatch_put(self, key, key.size, value, value.size)
    end

    def put(column_family : ColumnFamilyHandle, key : Bytes, value : Bytes) : Nil
      LibRocksDB.writebatch_put_cf(self, key, column_family, key.size, value, value.size)
    end

    def delete(key : Bytes) : Nil
      LibRocksDB.writebatch_delete(self, key, key.size)
    end

    def delete(column_family : ColumnFamilyHandle, key : Bytes) : Nil
      LibRocksDB.writebatch_delete_cf(self, column_family, key, key.size)
    end
  end
end
