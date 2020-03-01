require "../librocksdb"

module RocksDB
  class SstFileWriter
    def initialize(env_options : EnvOptions, options : Options)
      @value = LibRocksDB.sstfilewriter_create(env_options, options)
    end

    def initialize(env_options : EnvOptions, options : Options, compactor : Compactor)
      @value = LibRocksDB.sstfilewriter_create_with_comparator(env_options, options, compactor)
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.sstfilewriter_destroy(self)
    end

    def open(path : String) : Nil
      RocksDB.err_check do |err|
        LibRocksDB.sstfilewriter_open(self, path, err)
      end
    end

    def put(key : Bytes, value : Bytes) : Nil
      RocksDB.err_check do |err|
        LibRocksDB.sstfilewriter_put(self, key, key.size, value, value.size, err)
      end
    end

    def merge(key : Bytes, value : Bytes) : Nil
      RocksDB.err_check do |err|
        LibRocksDB.sstfilewriter_merge(self, key, key.size, value, value.size, err)
      end
    end

    def delete(key : Bytes) : Nil
      RocksDB.err_check do |err|
        LibRocksDB.sstfilewriter_delete(self, key, key.size, err)
      end
    end

    def finish : Nil
      RocksDB.err_check do |err|
        LibRocksDB.sstfilewriter_finish(self, err)
      end
    end

    def file_size : UInt64
      LibRocksDB.sstfilewriter_file_size(self, out size)
      size
    end
  end
end
