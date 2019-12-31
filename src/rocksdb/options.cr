lib LibRocksDB
  struct Options
    dummy : UInt8
  end

  fun options_create = rocksdb_options_create : Options*
  fun options_destroy = rocksdb_options_destroy(options : Options*)
  fun options_set_create_if_missing = rocksdb_options_set_create_if_missing(options : Options*, value : UInt8)
  fun options_set_paranoid_checks = rocksdb_options_set_paranoid_checks(options : Options*, value : UInt8)
  fun options_set_enable_pipelined_write = rocksdb_options_set_enable_pipelined_write(options : Options*, value : UInt8)
  fun options_increase_parallelism = rocksdb_options_increase_parallelism(options : Options*, value : LibC::Int)
  fun options_set_max_background_jobs = rocksdb_options_set_max_background_jobs(options : Options*, value : LibC::Int)

  struct ReadOptions
    dummy : UInt8
  end

  fun readoptions_create = rocksdb_readoptions_create : ReadOptions*
  fun readoptions_destroy = rocksdb_readoptions_destroy(read_options : ReadOptions*)
  fun readoptions_set_iterate_upper_bound = rocksdb_readoptions_set_iterate_upper_bound(read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT)
  fun readoptions_set_iterate_lower_bound = rocksdb_readoptions_set_iterate_lower_bound(read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT)
  fun readoptions_set_snapshot = rocksdb_readoptions_set_snapshot(read_options : ReadOptions*, snapshot : Snapshot*)

  struct WriteOptions
    dummy : UInt8
  end

  fun writeoptions_create = rocksdb_writeoptions_create : WriteOptions*
  fun writeoptions_destroy = rocksdb_writeoptions_destroy(write_options : WriteOptions*)
  fun writeoptions_set_sync = rocksdb_writeoptions_set_sync(write_options : WriteOptions*, value : UInt8)
  fun writeoptions_disable_WAL = rocksdb_writeoptions_disable_WAL(write_options : WriteOptions*, value : LibC::Int)
  fun writeoptions_set_ignore_missing_column_families = rocksdb_writeoptions_set_ignore_missing_column_families(write_options : WriteOptions*, value : UInt8)
  fun writeoptions_set_no_slowdown = rocksdb_writeoptions_set_no_slowdown(write_options : WriteOptions*, value : UInt8)
  fun writeoptions_set_low_pri = rocksdb_writeoptions_set_low_pri(write_options : WriteOptions*, value : UInt8)
  fun writeoptions_set_memtable_insert_hint_per_batch = rocksdb_writeoptions_set_memtable_insert_hint_per_batch(write_options : WriteOptions*, value : UInt8)
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

    def enable_pipelined_write=(value : Bool)
      LibRocksDB.options_set_enable_pipelined_write(self, value ? 1 : 0)
    end

    def increase_parallelism(total_threads : Int = 16)
      LibRocksDB.options_increase_parallelism(self, total_threads)
    end

    def max_background_jobs=(value : Int)
      LibRocksDB.options_set_max_background_jobs(self, value)
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

    def snapshot=(snapshot : BaseSnapshot)
      LibRocksDB.readoptions_set_readoptions_set_snapshot(self, snapshot)
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

    def sync=(value : Bool)
      LibRocksDB.writeoptions_set_sync(self, value ? 1 : 0)
    end

    def disable_wal=(value : Bool)
      LibRocksDB.writeoptions_disable_WAL(self, value ? 1 : 0)
    end

    def ignore_missing_column_families=(value : Bool)
      LibRocksDB.writeoptions_set_ignore_missing_column_families(self, value ? 1 : 0)
    end

    def no_slowdown=(value : Bool)
      LibRocksDB.writeoptions_set_no_slowdown(self, value ? 1 : 0)
    end

    def low_priority=(value : Bool)
      LibRocksDB.writeoptions_set_low_pri(self, value ? 1 : 0)
    end

    def writeoptions_set_memtable_insert_hint_per_batch=(value : Bool)
      LibRocksDB.writeoptions_set_memtable_insert_hint_per_batch(self, value ? 1 : 0)
    end
  end
end
