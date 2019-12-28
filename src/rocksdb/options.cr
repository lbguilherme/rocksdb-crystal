lib LibRocksDB
  struct Options
    dummy : UInt8
  end

  fun options_create = rocksdb_options_create : Options*
  fun options_destroy = rocksdb_options_destroy(options : Options*) : Void
  fun options_set_create_if_missing = rocksdb_options_set_create_if_missing(options : Options*, value : UInt8) : Void
  fun options_set_paranoid_checks = rocksdb_options_set_paranoid_checks(options : Options*, value : UInt8) : Void

  struct ReadOptions
    dummy : UInt8
  end

  fun readoptions_create = rocksdb_readoptions_create : ReadOptions*
  fun readoptions_destroy = rocksdb_readoptions_destroy(read_options : ReadOptions*) : Void
  fun readoptions_set_iterate_upper_bound = rocksdb_readoptions_set_iterate_upper_bound(read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT)
  fun readoptions_set_iterate_lower_bound = rocksdb_readoptions_set_iterate_lower_bound(read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT)

  struct WriteOptions
    dummy : UInt8
  end

  fun writeoptions_create = rocksdb_writeoptions_create : WriteOptions*
  fun writeoptions_destroy = rocksdb_writeoptions_destroy(write_options : WriteOptions*) : Void
end

module RocksDB
  class Options
    def initialize
      @value = LibRocksDB.options_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.options_destroy(self)
    end

    def create_if_missing=(value : Bool)
      LibRocksDB.options_set_create_if_missing(self, value ? 1 : 0)
    end

    def paranoid_checks=(value : Bool)
      LibRocksDB.options_set_paranoid_checks(self, value ? 1 : 0)
    end
  end

  class ReadOptions
    def initialize
      @value = LibRocksDB.readoptions_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.readoptions_destroy(self)
    end

    def iterate_upper_bound=(key : Bytes)
      LibRocksDB.readoptions_set_iterate_upper_bound(self, key, key.size)
    end

    def iterate_lower_bound=(key : Bytes)
      LibRocksDB.readoptions_set_iterate_lower_bound(self, key, key.size)
    end
  end

  class WriteOptions
    def initialize
      @value = LibRocksDB.writeoptions_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.writeoptions_destroy(self)
    end
  end
end
