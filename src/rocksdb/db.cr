lib LibRocksDb
  struct Db
    dummy : UInt8
  end

  fun open = rocksdb_open(options : Options*, name : UInt8*, errptr : UInt8**) : Db*
  fun close = rocksdb_close(db : Db*) : Void
  fun get = rocksdb_get(db : Db*, read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : UInt8**) : UInt8*
  fun put = rocksdb_put(db : Db*, write_options : WriteOptions*, key : UInt8*, keylen : LibC::SizeT, val : UInt8*, vallen : LibC::SizeT, errptr : UInt8**) : Void
end

module RocksDb
  class ClosedDatabaseError < Error
  end

  class Database
    def initialize(@value : LibRocksDb::Db*)
      @default_read_options = ReadOptions.new
      @default_write_options = WriteOptions.new
    end

    def to_unsafe
      @value
    end

    def finalize
      close unless @value.null?
    end

    def close
      LibRocksDb.close(self)
      @value = Pointer(LibRocksDb::Db).null
    end

    def self.open(path : String, options : Options)
      new(RocksDb.err_check do |err|
        LibRocksDb.open(options, path, err)
      end)
    end

    def get(key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      raise ClosedDatabaseError.new if @value.null?
      len = uninitialized LibC::SizeT
      ptr = RocksDb.err_check do |err|
        LibRocksDb.get(self, read_options, key, key.size, pointerof(len), err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def put(key : Bytes, value : Bytes, write_options : WriteOptions = @default_write_options)
      raise ClosedDatabaseError.new if @value.null?
      RocksDb.err_check do |err|
        LibRocksDb.put(self, write_options, key, key.size, value, value.size, err)
      end
    end

    def iterator(read_options : ReadOptions = @default_read_options)
      raise ClosedDatabaseError.new if @value.null?
      Iterator.new(LibRocksDb.create_iterator(self, read_options))
    end
  end
end
