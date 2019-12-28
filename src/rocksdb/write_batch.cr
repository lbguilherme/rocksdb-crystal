lib LibRocksDB
  struct WriteBatch
    dummy : UInt8
  end

  fun writebatch_create = rocksdb_writebatch_create() : WriteBatch*
  fun writebatch_destroy = rocksdb_writebatch_destroy(batch : WriteBatch*)
  fun writebatch_clear = rocksdb_writebatch_clear(batch : WriteBatch*)
  fun writebatch_count = rocksdb_writebatch_count(batch : WriteBatch*) : LibC::Int
  fun writebatch_put = rocksdb_writebatch_put(batch : WriteBatch*, key : UInt8*, keylen : LibC::SizeT, val : UInt8*, vallen : LibC::SizeT)
  fun writebatch_delete = rocksdb_writebatch_delete(batch : WriteBatch*, key : UInt8*, keylen : LibC::SizeT)
end

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
