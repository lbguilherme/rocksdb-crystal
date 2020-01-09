require "../librocksdb"

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
      LibRocksDB.readoptions_set_snapshot(self, snapshot)
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
      LibRocksDB.writeoptions_disable_wal(self, value ? 1 : 0)
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
