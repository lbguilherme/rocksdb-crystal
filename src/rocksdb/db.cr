lib LibRocksDB
  struct Db
    dummy : UInt8
  end

  fun open = rocksdb_open(options : Options*, name : UInt8*, errptr : UInt8**) : Db*
  fun close = rocksdb_close(db : Db*)
  fun get = rocksdb_get(db : Db*, read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : UInt8**) : UInt8*
  fun put = rocksdb_put(db : Db*, write_options : WriteOptions*, key : UInt8*, keylen : LibC::SizeT, val : UInt8*, vallen : LibC::SizeT, errptr : UInt8**)
  fun delete = rocksdb_delete(db : Db*, write_options : WriteOptions*, key : UInt8*, keylen : LibC::SizeT, errptr : UInt8**)
  fun write = rocksdb_write(db : Db*, write_options : WriteOptions*, batch : WriteBatch*, errptr : UInt8**)
end

module RocksDB
  class ClosedDatabaseError < Error
  end

  class Database
    def initialize(@value : LibRocksDB::Db*)
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
      LibRocksDB.close(self)
      @value = Pointer(LibRocksDB::Db).null
    end

    def self.open(path : String, options : Options)
      new(RocksDB.err_check do |err|
        LibRocksDB.open(options, path, err)
      end)
    end

    def get(key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      raise ClosedDatabaseError.new if @value.null?
      len = uninitialized LibC::SizeT
      ptr = RocksDB.err_check do |err|
        LibRocksDB.get(self, read_options, key, key.size, pointerof(len), err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def put(key : Bytes, value : Bytes, write_options : WriteOptions = @default_write_options)
      raise ClosedDatabaseError.new if @value.null?
      RocksDB.err_check do |err|
        LibRocksDB.put(self, write_options, key, key.size, value, value.size, err)
      end
    end

    def delete(key : Bytes, write_options : WriteOptions = @default_write_options)
      raise ClosedDatabaseError.new if @value.null?
      RocksDB.err_check do |err|
        LibRocksDB.delete(self, write_options, key, key.size, err)
      end
    end

    def write(batch : WriteBatch, write_options : WriteOptions = @default_write_options)
      raise ClosedDatabaseError.new if @value.null?
      RocksDB.err_check do |err|
        LibRocksDB.write(self, write_options, batch, err)
      end
    end

    def iterator(read_options : ReadOptions = @default_read_options)
      raise ClosedDatabaseError.new if @value.null?
      Iterator.new(LibRocksDB.create_iterator(self, read_options))
    end
  end
end
