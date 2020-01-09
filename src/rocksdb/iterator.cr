require "../librocksdb"

module RocksDB
  class Iterator
    def initialize(@value : LibRocksDB::Iterator*, @database : Database | TransactionDatabase)
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.iter_destroy(self) unless @database.closed?
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
