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

    def set_uint64add_merge_operator
      LibRocksDB.options_set_uint64add_merge_operator(self)
    end

    def enable_statistics
      LibRocksDB.options_enable_statistics(self)
    end

    def prepare_for_bulk_load
      LibRocksDB.options_prepare_for_bulk_load(self)
    end

    def set_memtable_vector_rep
      LibRocksDB.options_set_memtable_vector_rep(self)
    end

    def block_based_table_factory=(table_options : BlockBasedTableOptions)
      LibRocksDB.options_set_block_based_table_factory(self, table_options)
    end

    def cuckoo_table_factory=(table_options : CuckooTableOptions)
      LibRocksDB.options_set_cuckoo_table_factory(self, table_options)
    end

    def increase_parallelism(total_threads : Int = 16)
      LibRocksDB.options_increase_parallelism(self, total_threads)
    end

    def optimize_for_point_lookup(block_cache_size_mb : UInt64)
      LibRocksDB.options_optimize_for_point_lookup(self, block_cache_size_mb)
    end

    def optimize_level_style_compaction(memtable_memory_budget : UInt64)
      LibRocksDB.options_optimize_level_style_compaction(self, memtable_memory_budget)
    end

    def optimize_universal_style_compaction(memtable_memory_budget : UInt64)
      LibRocksDB.options_optimize_universal_style_compaction(self, memtable_memory_budget)
    end

    def allow_ingest_behind=(value : Bool)
      LibRocksDB.options_set_allow_ingest_behind(self, value ? 1 : 0)
    end

    def compaction_filter=(filter : CompactionFilter)
      LibRocksDB.options_set_compaction_filter(self, filter)
    end

    def compaction_filter_factory=(filter_factory : CompactionFilterFactory)
      LibRocksDB.options_set_compaction_filter_factory(self, filter_factory)
    end

    def compaction_readahead_size(size : LibC::SizeT)
      LibRocksDB.options_compaction_readahead_size(self, size)
    end

    def comparator=(comparator : Comparator)
      LibRocksDB.options_set_comparator(self, comparator)
    end

    def merge_operator=(merge_operator : MergeOperator)
      LibRocksDB.options_set_merge_operator(self, merge_operator)
    end

    # def compression_per_level=(level_values : LibC::Int*, num_levels : LibC::SizeT)
    #   LibRocksDB.options_set_compression_per_level(self, )
    # end

    def create_if_missing=(value : Bool)
      LibRocksDB.options_set_create_if_missing(self, value ? 1 : 0)
    end

    def create_missing_column_families=(value : Bool)
      LibRocksDB.options_set_create_missing_column_families(self, value ? 1 : 0)
    end

    def error_if_exists=(value : Bool)
      LibRocksDB.options_set_error_if_exists(self, value ? 1 : 0)
    end

    def paranoid_checks=(value : Bool)
      LibRocksDB.options_set_paranoid_checks(self, value ? 1 : 0)
    end

    # def db_paths=(path_values : DbPath**, num_paths : LibC::SizeT)
    #   LibRocksDB.options_set_db_paths(self, )
    # end

    def env=(env : Env)
      LibRocksDB.options_set_env(self, env)
    end

    def info_log=(logger : Logger)
      LibRocksDB.options_set_info_log(self, logger)
    end

    def info_log_level=(log_level : Int)
      LibRocksDB.options_set_info_log_level(self, log_level)
    end

    def write_buffer_size=(write_buffer_size : LibC::SizeT)
      LibRocksDB.options_set_write_buffer_size(self, write_buffer_size)
    end

    def db_write_buffer_size=(db_write_buffer_size : LibC::SizeT)
      LibRocksDB.options_set_db_write_buffer_size(self, db_write_buffer_size)
    end

    def max_open_files=(max_open_files : LibC::Int)
      LibRocksDB.options_set_max_open_files(self, max_open_files)
    end

    def max_file_opening_threads=(max_file_opening_threads : Int)
      LibRocksDB.options_set_max_file_opening_threads(self, max_file_opening_threads)
    end

    def max_total_wal_size=(max_total_wal_size : UInt64)
      LibRocksDB.options_set_max_total_wal_size(self, max_total_wal_size)
    end

    def set_compression_options(w_bits : Int, level : Int, strategy : Int, max_dict_bytes : Int)
      LibRocksDB.options_set_compression_options(self, w_bits, leve, strategy, max_dict_bytes)
    end

    def prefix_extractor=(slice_transform : SliceTransform)
      LibRocksDB.options_set_prefix_extractor(self, slice_transform)
    end

    def num_levels=(num_levels : LibC::Int)
      LibRocksDB.options_set_num_levels(self, num_levels)
    end

    def level0_file_num_compaction_trigger=(value : Int)
      LibRocksDB.options_set_level0_file_num_compaction_trigger(self, value)
    end

    def level0_slowdown_writes_trigger=(value : Int)
      LibRocksDB.options_set_level0_slowdown_writes_trigger(self, value)
    end

    def level0_stop_writes_trigger=(value : Int)
      LibRocksDB.options_set_level0_stop_writes_trigger(self, value)
    end

    def max_mem_compaction_level=(value : Int)
      LibRocksDB.options_set_max_mem_compaction_level(self, value)
    end

    def target_file_size_base=(target_file_size_base : UInt64)
      LibRocksDB.options_set_target_file_size_base(self, target_file_size_base)
    end

    def target_file_size_multiplier=(value : Int)
      LibRocksDB.options_set_target_file_size_multiplier(self, value)
    end

    def max_bytes_for_level_base=(max_bytes_for_level_base : UInt64)
      LibRocksDB.options_set_max_bytes_for_level_base(self, max_bytes_for_level_base)
    end

    def snap_refresh_nanos=(value : UInt64)
      LibRocksDB.options_set_snap_refresh_nanos(self, value)
    end

    def level_compaction_dynamic_level_bytes=(value : Bool)
      LibRocksDB.options_set_level_compaction_dynamic_level_bytes(self, value ? 1 : 0)
    end

    def max_bytes_for_level_multiplier=(multiplier : Float64)
      LibRocksDB.options_set_max_bytes_for_level_multiplier(self, multiplier)
    end

    # def max_bytes_for_level_multiplier_additional=(level_values : LibC::Int*, num_levels : LibC::SizeT)
    #   LibRocksDB.options_set_max_bytes_for_level_multiplier_additional(self, )
    # end

    def skip_stats_update_on_db_open=(val : UInt8)
      LibRocksDB.options_set_skip_stats_update_on_db_open(self, val)
    end

    def statistics_get_string
      value = LibRocksDB.options_statistics_get_string(self)
      str = String.new(value)
      RocksDB.free(value)
      str
    end

    def max_write_buffer_number=(value : Int)
      LibRocksDB.options_set_max_write_buffer_number(self, value)
    end

    def min_write_buffer_number_to_merge=(value : Int)
      LibRocksDB.options_set_min_write_buffer_number_to_merge(self, value)
    end

    def max_write_buffer_number_to_maintain=(value : Int)
      LibRocksDB.options_set_max_write_buffer_number_to_maintain(self, value)
    end

    def max_write_buffer_size_to_maintain=(value : Int64)
      LibRocksDB.options_set_max_write_buffer_size_to_maintain(self, value)
    end

    def enable_pipelined_write=(value : Bool)
      LibRocksDB.options_set_enable_pipelined_write(self, value ? 1 : 0)
    end

    def unordered_write=(value : Bool)
      LibRocksDB.options_set_unordered_write(self, value ? 1 : 0)
    end

    def avoid_unnecessary_blocking_io=(value : Bool)
      LibRocksDB.options_set_avoid_unnecessary_blocking_io(self, value ? 1 : 0)
    end

    def max_subcompactions=(value : UInt32)
      LibRocksDB.options_set_max_subcompactions(self, value)
    end

    def max_background_jobs=(value : Int)
      LibRocksDB.options_set_max_background_jobs(self, value)
    end

    def max_background_compactions=(value : Int)
      LibRocksDB.options_set_max_background_compactions(self, value)
    end

    def base_background_compactions=(value : Int)
      LibRocksDB.options_set_base_background_compactions(self, value)
    end

    def max_background_flushes=(value : Int)
      LibRocksDB.options_set_max_background_flushes(self, value)
    end

    def max_log_file_size=(value : LibC::SizeT)
      LibRocksDB.options_set_max_log_file_size(self, value)
    end

    def log_file_time_to_roll=(value : LibC::SizeT)
      LibRocksDB.options_set_log_file_time_to_roll(self, value)
    end

    def keep_log_file_num=(value : LibC::SizeT)
      LibRocksDB.options_set_keep_log_file_num(self, value)
    end

    def recycle_log_file_num=(value : LibC::SizeT)
      LibRocksDB.options_set_recycle_log_file_num(self, value)
    end

    def soft_rate_limit=(value : Float64)
      LibRocksDB.options_set_soft_rate_limit(self, value)
    end

    def hard_rate_limit=(value : Float64)
      LibRocksDB.options_set_hard_rate_limit(self, value)
    end

    def soft_pending_compaction_bytes_limit=(value : LibC::SizeT)
      LibRocksDB.options_set_soft_pending_compaction_bytes_limit(self, value)
    end

    def hard_pending_compaction_bytes_limit=(value : LibC::SizeT)
      LibRocksDB.options_set_hard_pending_compaction_bytes_limit(self, value)
    end

    def rate_limit_delay_max_milliseconds=(value : UInt32)
      LibRocksDB.options_set_rate_limit_delay_max_milliseconds(self, value)
    end

    def max_manifest_file_size=(value : LibC::SizeT)
      LibRocksDB.options_set_max_manifest_file_size(self, value)
    end

    def table_cache_numshardbits=(value : Int)
      LibRocksDB.options_set_table_cache_numshardbits(self, value)
    end

    def table_cache_remove_scan_count_limit=(value : Int)
      LibRocksDB.options_set_table_cache_remove_scan_count_limit(self, value)
    end

    def arena_block_size=(x1 : LibC::SizeT)
      LibRocksDB.options_set_arena_block_size(self, value)
    end

    def use_fsync=(value : Int)
      LibRocksDB.options_set_use_fsync(self, value)
    end

    def db_log_dir=(dir : String)
      LibRocksDB.options_set_db_log_dir(self, dir)
    end

    def wal_dir=(dir : String)
      LibRocksDB.options_set_wal_dir(self, dir)
    end

    def wal_ttl_seconds=(value : UInt64)
      LibRocksDB.options_set_WAL_ttl_seconds(self, value)
    end

    def wal_size_limit_mb=(value : UInt64)
      LibRocksDB.options_set_WAL_size_limit_MB(self, value)
    end

    def manifest_preallocation_size=(value : LibC::SizeT)
      LibRocksDB.options_set_manifest_preallocation_size(self, value)
    end

    def purge_redundant_kvs_while_flush=(value : Bool)
      LibRocksDB.options_set_purge_redundant_kvs_while_flush(self, value ? 1 : 0)
    end

    def allow_mmap_reads=(value : Bool)
      LibRocksDB.options_set_allow_mmap_reads(self, value ? 1 : 0)
    end

    def allow_mmap_writes=(value : Bool)
      LibRocksDB.options_set_allow_mmap_writes(self, value ? 1 : 0)
    end

    def use_direct_reads=(value : Bool)
      LibRocksDB.options_set_use_direct_reads(self, value ? 1 : 0)
    end

    def use_direct_io_for_flush_and_compaction=(value : Bool)
      LibRocksDB.options_set_use_direct_io_for_flush_and_compaction(self, value ? 1 : 0)
    end

    def is_fd_close_on_exec=(value : Bool)
      LibRocksDB.options_set_is_fd_close_on_exec(self, value ? 1 : 0)
    end

    def skip_log_error_on_recovery=(value : Bool)
      LibRocksDB.options_set_skip_log_error_on_recovery(self, value ? 1 : 0)
    end

    def stats_dump_period_sec=(value : LibC::UInt)
      LibRocksDB.options_set_stats_dump_period_sec(self, value)
    end

    def advise_random_on_open=(value : Bool)
      LibRocksDB.options_set_advise_random_on_open(self, value ? 1 : 0)
    end

    def access_hint_on_compaction_start=(value : Int)
      LibRocksDB.options_set_access_hint_on_compaction_start(self, value)
    end

    def use_adaptive_mutex=(value : Bool)
      LibRocksDB.options_set_use_adaptive_mutex(self, value ? 1 : 0)
    end

    def bytes_per_sync=(value : UInt64)
      LibRocksDB.options_set_bytes_per_sync(self, value)
    end

    def wal_bytes_per_sync=(value : UInt64)
      LibRocksDB.options_set_wal_bytes_per_sync(self, value)
    end

    def writable_file_max_buffer_size=(value : UInt64)
      LibRocksDB.options_set_writable_file_max_buffer_size(self, value)
    end

    def allow_concurrent_memtable_write=(value : Bool)
      LibRocksDB.options_set_allow_concurrent_memtable_write(self, value ? 1 : 0)
    end

    def enable_write_thread_adaptive_yield=(value : Bool)
      LibRocksDB.options_set_enable_write_thread_adaptive_yield(self, value ? 1 : 0)
    end

    def max_sequential_skip_in_iterations=(value : UInt64)
      LibRocksDB.options_set_max_sequential_skip_in_iterations(self, value)
    end

    def disable_auto_compactions=(value : Int)
      LibRocksDB.options_set_disable_auto_compactions(self, value)
    end

    def optimize_filters_for_hits=(value : Int)
      LibRocksDB.options_set_optimize_filters_for_hits(self, value)
    end

    def delete_obsolete_files_period_micros=(value : UInt64)
      LibRocksDB.options_set_delete_obsolete_files_period_micros(self, value)
    end

    def memtable_prefix_bloom_size_ratio=(value : Float64)
      LibRocksDB.options_set_memtable_prefix_bloom_size_ratio(self, value)
    end

    def max_compaction_bytes=(value : UInt64)
      LibRocksDB.options_set_max_compaction_bytes(self, value)
    end

    # def hash_skip_list_rep=(x1 : LibC::SizeT, x2 : Int32*, x3 : Int32*)
    #   LibRocksDB.options_set_hash_skip_list_rep(self, )
    # end

    def hash_link_list_rep=(value : LibC::SizeT)
      LibRocksDB.options_set_hash_link_list_rep(self, value)
    end

    # def plain_table_factory=(x1 : UInt32, x2 : LibC::Int, x3 : Float64, x4 : LibC::SizeT)
    #   LibRocksDB.options_set_plain_table_factory(self, )
    # end

    def min_level_to_compress=(level : Int)
      LibRocksDB.options_set_min_level_to_compress(self, level)
    end

    def memtable_huge_page_size=(value : LibC::SizeT)
      LibRocksDB.options_set_memtable_huge_page_size(self, value)
    end

    def max_successive_merges=(value : LibC::SizeT)
      LibRocksDB.options_set_max_successive_merges(self, value)
    end

    def bloom_locality=(value : UInt32)
      LibRocksDB.options_set_bloom_locality(self, value)
    end

    def inplace_update_support=(value : Bool)
      LibRocksDB.options_set_inplace_update_support(self, value ? 1 : 0)
    end

    def inplace_update_num_locks=(value : LibC::SizeT)
      LibRocksDB.options_set_inplace_update_num_locks(self, value)
    end

    def report_bg_io_stats=(value : Int)
      LibRocksDB.options_set_report_bg_io_stats(self, value)
    end

    def wal_recovery_mode=(value : Int)
      LibRocksDB.options_set_wal_recovery_mode(self, value)
    end

    def compression=(value : Int)
      LibRocksDB.options_set_compression(self, value)
    end

    def compaction_style=(value : Int)
      LibRocksDB.options_set_compaction_style(self, value)
    end

    def universal_compaction_options=(universal_compaction_options : UniversalCompactionOptions)
      LibRocksDB.options_set_universal_compaction_options(self, universal_compaction_options)
    end

    def fifo_compaction_options=(fifo_compaction_options : FifoCompactionOptions)
      LibRocksDB.options_set_fifo_compaction_options(self, fifo_compaction_options)
    end

    def ratelimiter=(limiter : RateLimiter)
      LibRocksDB.options_set_ratelimiter(self, limiter)
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

    def snapshot=(snapshot : BaseSnapshot)
      LibRocksDB.readoptions_set_snapshot(self, snapshot)
    end

    def iterate_lower_bound=(key : Bytes)
      LibRocksDB.readoptions_set_iterate_lower_bound(self, key, key.size)
    end

    def iterate_upper_bound=(key : Bytes)
      LibRocksDB.readoptions_set_iterate_upper_bound(self, key, key.size)
    end

    def readahead_size=(size : Int)
      LibRocksDB.readoptions_set_readahead_size(self, size)
    end

    def max_skippable_internal_keys=(value : Int)
      LibRocksDB.readoptions_set_max_skippable_internal_keys(self, value)
    end

    def verify_checksums=(value : Bool)
      LibRocksDB.readoptions_set_verify_checksums(self, value ? 1 : 0)
    end

    def fill_cache=(value : Bool)
      LibRocksDB.readoptions_set_fill_cache(self, value ? 1 : 0)
    end

    def tailing=(value : Bool)
      LibRocksDB.readoptions_set_tailing(self, value ? 1 : 0)
    end

    def total_order_seek=(value : Bool)
      LibRocksDB.readoptions_set_total_order_seek(self, value ? 1 : 0)
    end

    def prefix_same_as_start=(value : Bool)
      LibRocksDB.readoptions_set_prefix_same_as_start(self, value ? 1 : 0)
    end

    def pin_data=(value : Bool)
      LibRocksDB.readoptions_set_pin_data(self, value ? 1 : 0)
    end

    def background_purge_on_iterator_cleanup=(value : Bool)
      LibRocksDB.readoptions_set_background_purge_on_iterator_cleanup(self, value ? 1 : 0)
    end

    def ignore_range_deletions=(value : Bool)
      LibRocksDB.readoptions_set_ignore_range_deletions(self, value ? 1 : 0)
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

  class EnvOptions
    def initialize
      @value = LibRocksDB.envoptions_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.envoptions_destroy(self)
    end
  end

  class IngestExternalFileOptions
    def initialize
      @value = LibRocksDB.ingestexternalfileoptions_create
    end

    def to_unsafe
      @value
    end

    def finalize
      LibRocksDB.ingestexternalfileoptions_destroy(self)
    end

    def move_files=(move_files : Bool)
      LibRocksDB.ingestexternalfileoptions_set_move_files(self, move_files ? 1 : 0)
    end

    def snapshot_consistency=(snapshot_consistency : Bool)
      LibRocksDB.ingestexternalfileoptions_set_snapshot_consistency(self, snapshot_consistency ? 1 : 0)
    end

    def allow_global_seqno=(allow_global_seqno : Bool)
      LibRocksDB.ingestexternalfileoptions_set_allow_global_seqno(self, allow_global_seqno ? 1 : 0)
    end

    def allow_blocking_flush=(allow_blocking_flush : Bool)
      LibRocksDB.ingestexternalfileoptions_set_allow_blocking_flush(self, allow_blocking_flush ? 1 : 0)
    end

    def ingest_behind=(ingest_behind : Bool)
      LibRocksDB.ingestexternalfileoptions_set_ingest_behind(self, ingest_behind ? 1 : 0)
    end
  end
end
