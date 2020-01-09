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

    def put(key : Bytes, value : Bytes)
      LibRocksDB.writebatch_put(self, key, key.size, value, value.size)
    end

    def delete(key : Bytes)
      LibRocksDB.writebatch_delete(self, key, key.size)
    end
  end
end
