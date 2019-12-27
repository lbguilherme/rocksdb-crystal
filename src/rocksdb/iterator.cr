lib LibRocksDb
  struct Iterator
    dummy : UInt8
  end

  fun create_iterator = rocksdb_create_iterator(db : Db*, read_options : ReadOptions*) : Iterator*
  fun iter_destroy = rocksdb_iter_destroy(iter : Iterator*)
  fun iter_valid = rocksdb_iter_valid(iter : Iterator*) : UInt8
  fun iter_seek_to_first = rocksdb_iter_seek_to_first(iter : Iterator*) : Void
  fun iter_seek_to_last = rocksdb_iter_seek_to_last(iter : Iterator*) : Void
  fun iter_seek = rocksdb_iter_seek(iter : Iterator*, key : UInt8*, keylen : LibC::SizeT) : Void
  fun iter_seek_for_prev = rocksdb_iter_seek_for_prev(iter : Iterator*, key : UInt8*, keylen : LibC::SizeT) : Void
  fun iter_next = rocksdb_iter_next(iter : Iterator*) : Void
  fun iter_prev = rocksdb_iter_prev(iter : Iterator*) : Void
  fun iter_key = rocksdb_iter_key(iter : Iterator*, keylen : LibC::SizeT*) : UInt8*
  fun iter_value = rocksdb_iter_value(iter : Iterator*, vallen : LibC::SizeT*) : UInt8*
  fun iter_get_error = rocksdb_iter_get_error(iter : Iterator*, errptr : UInt8**) : Void
end

module RocksDb
  class Iterator
    def initialize(@value : LibRocksDb::Iterator*)
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDb.iter_destroy(self)
    end

    def valid?
      result = LibRocksDb.iter_valid(self) != 0
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
      result
    end

    def seek_to_first
      LibRocksDb.iter_seek_to_first(self)
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
    end

    def seek_to_last
      LibRocksDb.iter_seek_to_last(self)
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
    end

    def seek(key : Bytes)
      LibRocksDb.iter_seek(self, key, key.size)
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
    end

    def seek_for_prev(key : Bytes)
      LibRocksDb.iter_seek_for_prev(self, key, key.size)
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
    end

    def next
      LibRocksDb.iter_next(self)
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
    end

    def prev
      LibRocksDb.iter_prev(self)
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
    end

    def key
      len = LibC::SizeT.new(0)
      ptr = LibRocksDb.iter_key(self, pointerof(len))
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
      Bytes.new(ptr, len)
    end

    def value
      len = LibC::SizeT.new(0)
      ptr = LibRocksDb.iter_value(self, pointerof(len))
      err_check { |err| LibRocksDb.iter_get_error(self, err) }
      Bytes.new(ptr, len)
    end
  end
end
