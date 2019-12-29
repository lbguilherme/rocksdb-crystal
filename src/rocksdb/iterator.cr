lib LibRocksDB
  struct Iterator
    dummy : UInt8
  end

  fun iter_destroy = rocksdb_iter_destroy(iter : Iterator*)
  fun iter_valid = rocksdb_iter_valid(iter : Iterator*) : UInt8
  fun iter_seek_to_first = rocksdb_iter_seek_to_first(iter : Iterator*)
  fun iter_seek_to_last = rocksdb_iter_seek_to_last(iter : Iterator*)
  fun iter_seek = rocksdb_iter_seek(iter : Iterator*, key : UInt8*, keylen : LibC::SizeT)
  fun iter_seek_for_prev = rocksdb_iter_seek_for_prev(iter : Iterator*, key : UInt8*, keylen : LibC::SizeT)
  fun iter_next = rocksdb_iter_next(iter : Iterator*)
  fun iter_prev = rocksdb_iter_prev(iter : Iterator*)
  fun iter_key = rocksdb_iter_key(iter : Iterator*, keylen : LibC::SizeT*) : UInt8*
  fun iter_value = rocksdb_iter_value(iter : Iterator*, vallen : LibC::SizeT*) : UInt8*
  fun iter_get_error = rocksdb_iter_get_error(iter : Iterator*, errptr : UInt8**)
end

module RocksDB
  class Iterator
    def initialize(@value : LibRocksDB::Iterator*)
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.iter_destroy(self)
    end

    def valid?
      result = LibRocksDB.iter_valid(self) != 0
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
      result
    end

    def seek_to_first
      LibRocksDB.iter_seek_to_first(self)
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
    end

    def seek_to_last
      LibRocksDB.iter_seek_to_last(self)
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
    end

    def seek(key : Bytes)
      LibRocksDB.iter_seek(self, key, key.size)
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
    end

    def seek_for_prev(key : Bytes)
      LibRocksDB.iter_seek_for_prev(self, key, key.size)
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
    end

    def next
      LibRocksDB.iter_next(self)
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
    end

    def prev
      LibRocksDB.iter_prev(self)
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
    end

    def key
      len = LibC::SizeT.new(0)
      ptr = LibRocksDB.iter_key(self, pointerof(len))
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
      Bytes.new(ptr, len)
    end

    def value
      len = LibC::SizeT.new(0)
      ptr = LibRocksDB.iter_value(self, pointerof(len))
      RocksDB.err_check { |err| LibRocksDB.iter_get_error(self, err) }
      Bytes.new(ptr, len)
    end
  end
end
