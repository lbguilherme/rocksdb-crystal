require "../librocksdb"

module RocksDB
  def self.free(ptr : UInt8* | Bytes)
    LibRocksDB.free(ptr)
  end

  def self.err_check
    err = Pointer(UInt8).null
    result = yield pointerof(err)
    unless err.null?
      str = String.new(err)
      RocksDB.free(err)
      raise RocksDB::Error.new(str)
    end
    result
  end

  class Error < Exception
  end
end
