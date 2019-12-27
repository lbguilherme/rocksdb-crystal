@[Link("rocksdb")]
lib LibRocksDb
  fun free = rocksdb_free(ptr : Void*) : Void
end

module RocksDb
  def self.free(ptr : UInt8* | Bytes)
    LibRocksDb.free(ptr)
  end

  def self.err_check
    err = Pointer(UInt8).null
    result = yield pointerof(err)
    unless err.null?
      str = String.new(err)
      puts str
      RocksDb.free(err)
      raise RocksDb::Error.new(str)
    end
    result
  end

  class Error < Exception
  end
end

require "./rocksdb/*"
