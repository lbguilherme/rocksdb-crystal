# Generated from c.h from RocksDB 6.5.2

@[Link(ldflags: "-lrocksdb -lstdc++")]
lib LibRocksDB
  struct Db
    dummy : UInt8
  end

  struct BackupEngine
    dummy : UInt8
  end

  struct BackupEngineInfo
    dummy : UInt8
  end

  struct RestoreOptions
    dummy : UInt8
  end

  struct Cache
    dummy : UInt8
  end

  struct CompactionFilter
    dummy : UInt8
  end

  struct CompactionFilterContext
    dummy : UInt8
  end

  struct CompactionFilterFactory
    dummy : UInt8
  end

  struct Comparator
    dummy : UInt8
  end

  struct DbPath
    dummy : UInt8
  end

  struct Env
    dummy : UInt8
  end

  struct FifoCompactionOptions
    dummy : UInt8
  end

  struct FilterPolicy
    dummy : UInt8
  end

  struct FlushOptions
    dummy : UInt8
  end

  struct Iterator
    dummy : UInt8
  end

  struct Logger
    dummy : UInt8
  end

  struct MergeOperator
    dummy : UInt8
  end

  struct Options
    dummy : UInt8
  end

  struct CompactOptions
    dummy : UInt8
  end

  struct BlockBasedTableOptions
    dummy : UInt8
  end

  struct CuckooTableOptions
    dummy : UInt8
  end

  struct ReadOptions
    dummy : UInt8
  end

  struct SliceTransform
    dummy : UInt8
  end

  struct Snapshot
    dummy : UInt8
  end

  struct WriteBatch
    dummy : UInt8
  end

  struct WriteBatchWi
    dummy : UInt8
  end

  struct WriteOptions
    dummy : UInt8
  end

  struct UniversalCompactionOptions
    dummy : UInt8
  end

  struct LiveFiles
    dummy : UInt8
  end

  struct ColumnFamilyHandle
    dummy : UInt8
  end

  struct EnvOptions
    dummy : UInt8
  end

  struct IngestExternalFileOptions
    dummy : UInt8
  end

  struct SstFileWriter
    dummy : UInt8
  end

  struct RateLimiter
    dummy : UInt8
  end

  struct PerfContext
    dummy : UInt8
  end

  struct PinnableSlice
    dummy : UInt8
  end

  struct TransactionDbOptions
    dummy : UInt8
  end

  struct TransactionDb
    dummy : UInt8
  end

  struct TransactionOptions
    dummy : UInt8
  end

  struct OptimisticTransactionDb
    dummy : UInt8
  end

  struct OptimisticTransactionOptions
    dummy : UInt8
  end

  struct Transaction
    dummy : UInt8
  end

  struct Checkpoint
    dummy : UInt8
  end

  struct WalIterator
    dummy : UInt8
  end

  struct WalReadOptions
    dummy : UInt8
  end

  struct MemoryConsumers
    dummy : UInt8
  end

  struct MemoryUsage
    dummy : UInt8
  end

  fun open = rocksdb_open(options : Options*, name : LibC::Char*, errptr : LibC::Char**) : Db*
  fun open_with_ttl = rocksdb_open_with_ttl(options : Options*, name : LibC::Char*, ttl : LibC::Int, errptr : LibC::Char**) : Db*
  fun open_for_read_only = rocksdb_open_for_read_only(options : Options*, name : LibC::Char*, error_if_log_file_exist : UInt8, errptr : LibC::Char**) : Db*
  fun open_as_secondary = rocksdb_open_as_secondary(options : Options*, name : LibC::Char*, secondary_path : LibC::Char*, errptr : LibC::Char**) : Db*
  fun backup_engine_open = rocksdb_backup_engine_open(options : Options*, path : LibC::Char*, errptr : LibC::Char**) : BackupEngine*
  fun backup_engine_create_new_backup = rocksdb_backup_engine_create_new_backup(be : BackupEngine*, db : Db*, errptr : LibC::Char**)
  fun backup_engine_create_new_backup_flush = rocksdb_backup_engine_create_new_backup_flush(be : BackupEngine*, db : Db*, flush_before_backup : UInt8, errptr : LibC::Char**)
  fun backup_engine_purge_old_backups = rocksdb_backup_engine_purge_old_backups(be : BackupEngine*, num_backups_to_keep : UInt32, errptr : LibC::Char**)
  fun restore_options_create = rocksdb_restore_options_create : RestoreOptions*
  fun restore_options_destroy = rocksdb_restore_options_destroy(opt : RestoreOptions*)
  fun restore_options_set_keep_log_files = rocksdb_restore_options_set_keep_log_files(opt : RestoreOptions*, v : LibC::Int)
  fun backup_engine_verify_backup = rocksdb_backup_engine_verify_backup(be : BackupEngine*, backup_id : UInt32, errptr : LibC::Char**)
  fun backup_engine_restore_db_from_latest_backup = rocksdb_backup_engine_restore_db_from_latest_backup(be : BackupEngine*, db_dir : LibC::Char*, wal_dir : LibC::Char*, restore_options : RestoreOptions*, errptr : LibC::Char**)
  fun backup_engine_get_backup_info = rocksdb_backup_engine_get_backup_info(be : BackupEngine*) : BackupEngineInfo*
  fun backup_engine_info_count = rocksdb_backup_engine_info_count(info : BackupEngineInfo*) : LibC::Int
  fun backup_engine_info_timestamp = rocksdb_backup_engine_info_timestamp(info : BackupEngineInfo*, index : LibC::Int) : Int64*
  fun backup_engine_info_backup_id = rocksdb_backup_engine_info_backup_id(info : BackupEngineInfo*, index : LibC::Int) : UInt32
  fun backup_engine_info_size = rocksdb_backup_engine_info_size(info : BackupEngineInfo*, index : LibC::Int) : UInt64*
  fun backup_engine_info_number_files = rocksdb_backup_engine_info_number_files(info : BackupEngineInfo*, index : LibC::Int) : UInt32
  fun backup_engine_info_destroy = rocksdb_backup_engine_info_destroy(info : BackupEngineInfo*)
  fun backup_engine_close = rocksdb_backup_engine_close(be : BackupEngine*)
  fun checkpoint_object_create = rocksdb_checkpoint_object_create(db : Db*, errptr : LibC::Char**) : Checkpoint*
  fun checkpoint_create = rocksdb_checkpoint_create(checkpoint : Checkpoint*, checkpoint_dir : LibC::Char*, log_size_for_flush : UInt64*, errptr : LibC::Char**)
  fun checkpoint_object_destroy = rocksdb_checkpoint_object_destroy(checkpoint : Checkpoint*)
  fun open_column_families = rocksdb_open_column_families(options : Options*, name : LibC::Char*, num_column_families : LibC::Int, column_family_names : LibC::Char**, column_family_options : Options**, column_family_handles : ColumnFamilyHandle**, errptr : LibC::Char**) : Db*
  fun open_for_read_only_column_families = rocksdb_open_for_read_only_column_families(options : Options*, name : LibC::Char*, num_column_families : LibC::Int, column_family_names : LibC::Char**, column_family_options : Options**, column_family_handles : ColumnFamilyHandle**, error_if_log_file_exist : UInt8, errptr : LibC::Char**) : Db*
  fun open_as_secondary_column_families = rocksdb_open_as_secondary_column_families(options : Options*, name : LibC::Char*, secondary_path : LibC::Char*, num_column_families : LibC::Int, column_family_names : LibC::Char**, column_family_options : Options**, colummn_family_handles : ColumnFamilyHandle**, errptr : LibC::Char**) : Db*
  fun list_column_families = rocksdb_list_column_families(options : Options*, name : LibC::Char*, lencf : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char**
  fun list_column_families_destroy = rocksdb_list_column_families_destroy(list : LibC::Char**, len : LibC::SizeT)
  fun create_column_family = rocksdb_create_column_family(db : Db*, column_family_options : Options*, column_family_name : LibC::Char*, errptr : LibC::Char**) : ColumnFamilyHandle*
  fun drop_column_family = rocksdb_drop_column_family(db : Db*, handle : ColumnFamilyHandle*, errptr : LibC::Char**)
  fun column_family_handle_destroy = rocksdb_column_family_handle_destroy(x0 : ColumnFamilyHandle*)
  fun close = rocksdb_close(db : Db*)
  fun put = rocksdb_put(db : Db*, options : WriteOptions*, key : LibC::Char*, keylen : LibC::SizeT, val : LibC::Char*, vallen : LibC::SizeT, errptr : LibC::Char**)
  fun put_cf = rocksdb_put_cf(db : Db*, options : WriteOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, val : LibC::Char*, vallen : LibC::SizeT, errptr : LibC::Char**)
  fun delete = rocksdb_delete(db : Db*, options : WriteOptions*, key : LibC::Char*, keylen : LibC::SizeT, errptr : LibC::Char**)
  fun delete_cf = rocksdb_delete_cf(db : Db*, options : WriteOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, errptr : LibC::Char**)
  fun merge = rocksdb_merge(db : Db*, options : WriteOptions*, key : LibC::Char*, keylen : LibC::SizeT, val : LibC::Char*, vallen : LibC::SizeT, errptr : LibC::Char**)
  fun merge_cf = rocksdb_merge_cf(db : Db*, options : WriteOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, val : LibC::Char*, vallen : LibC::SizeT, errptr : LibC::Char**)
  fun write = rocksdb_write(db : Db*, options : WriteOptions*, batch : WriteBatch*, errptr : LibC::Char**)
  fun get = rocksdb_get(db : Db*, options : ReadOptions*, key : LibC::Char*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun get_cf = rocksdb_get_cf(db : Db*, options : ReadOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun multi_get = rocksdb_multi_get(db : Db*, options : ReadOptions*, num_keys : LibC::SizeT, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*, errs : LibC::Char**)
  fun multi_get_cf = rocksdb_multi_get_cf(db : Db*, options : ReadOptions*, column_families : ColumnFamilyHandle**, num_keys : LibC::SizeT, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*, errs : LibC::Char**)
  fun create_iterator = rocksdb_create_iterator(db : Db*, options : ReadOptions*) : Iterator*
  fun get_updates_since = rocksdb_get_updates_since(db : Db*, seq_number : UInt64*, options : WalReadOptions*, errptr : LibC::Char**) : WalIterator*
  fun create_iterator_cf = rocksdb_create_iterator_cf(db : Db*, options : ReadOptions*, column_family : ColumnFamilyHandle*) : Iterator*
  fun create_iterators = rocksdb_create_iterators(db : Db*, opts : ReadOptions*, column_families : ColumnFamilyHandle**, iterators : Iterator**, size : LibC::SizeT, errptr : LibC::Char**)
  fun create_snapshot = rocksdb_create_snapshot(db : Db*) : Snapshot*
  fun release_snapshot = rocksdb_release_snapshot(db : Db*, snapshot : Snapshot*)
  fun property_value = rocksdb_property_value(db : Db*, propname : LibC::Char*) : LibC::Char*
  fun property_int = rocksdb_property_int(db : Db*, propname : LibC::Char*, out_val : UInt64*) : LibC::Int
  fun property_int_cf = rocksdb_property_int_cf(db : Db*, column_family : ColumnFamilyHandle*, propname : LibC::Char*, out_val : UInt64*) : LibC::Int
  fun property_value_cf = rocksdb_property_value_cf(db : Db*, column_family : ColumnFamilyHandle*, propname : LibC::Char*) : LibC::Char*
  fun approximate_sizes = rocksdb_approximate_sizes(db : Db*, num_ranges : LibC::Int, range_start_key : LibC::Char**, range_start_key_len : LibC::SizeT*, range_limit_key : LibC::Char**, range_limit_key_len : LibC::SizeT*, sizes : UInt64*)
  fun approximate_sizes_cf = rocksdb_approximate_sizes_cf(db : Db*, column_family : ColumnFamilyHandle*, num_ranges : LibC::Int, range_start_key : LibC::Char**, range_start_key_len : LibC::SizeT*, range_limit_key : LibC::Char**, range_limit_key_len : LibC::SizeT*, sizes : UInt64*)
  fun compact_range = rocksdb_compact_range(db : Db*, start_key : LibC::Char*, start_key_len : LibC::SizeT, limit_key : LibC::Char*, limit_key_len : LibC::SizeT)
  fun compact_range_cf = rocksdb_compact_range_cf(db : Db*, column_family : ColumnFamilyHandle*, start_key : LibC::Char*, start_key_len : LibC::SizeT, limit_key : LibC::Char*, limit_key_len : LibC::SizeT)
  fun compact_range_opt = rocksdb_compact_range_opt(db : Db*, opt : CompactOptions*, start_key : LibC::Char*, start_key_len : LibC::SizeT, limit_key : LibC::Char*, limit_key_len : LibC::SizeT)
  fun compact_range_cf_opt = rocksdb_compact_range_cf_opt(db : Db*, column_family : ColumnFamilyHandle*, opt : CompactOptions*, start_key : LibC::Char*, start_key_len : LibC::SizeT, limit_key : LibC::Char*, limit_key_len : LibC::SizeT)
  fun delete_file = rocksdb_delete_file(db : Db*, name : LibC::Char*)
  fun livefiles = rocksdb_livefiles(db : Db*) : LiveFiles*
  fun flush = rocksdb_flush(db : Db*, options : FlushOptions*, errptr : LibC::Char**)
  fun flush_cf = rocksdb_flush_cf(db : Db*, options : FlushOptions*, column_family : ColumnFamilyHandle*, errptr : LibC::Char**)
  fun disable_file_deletions = rocksdb_disable_file_deletions(db : Db*, errptr : LibC::Char**)
  fun enable_file_deletions = rocksdb_enable_file_deletions(db : Db*, force : UInt8, errptr : LibC::Char**)
  fun destroy_db = rocksdb_destroy_db(options : Options*, name : LibC::Char*, errptr : LibC::Char**)
  fun repair_db = rocksdb_repair_db(options : Options*, name : LibC::Char*, errptr : LibC::Char**)
  fun iter_destroy = rocksdb_iter_destroy(x0 : Iterator*)
  fun iter_valid = rocksdb_iter_valid(x0 : Iterator*) : UInt8
  fun iter_seek_to_first = rocksdb_iter_seek_to_first(x0 : Iterator*)
  fun iter_seek_to_last = rocksdb_iter_seek_to_last(x0 : Iterator*)
  fun iter_seek = rocksdb_iter_seek(x0 : Iterator*, k : LibC::Char*, klen : LibC::SizeT)
  fun iter_seek_for_prev = rocksdb_iter_seek_for_prev(x0 : Iterator*, k : LibC::Char*, klen : LibC::SizeT)
  fun iter_next = rocksdb_iter_next(x0 : Iterator*)
  fun iter_prev = rocksdb_iter_prev(x0 : Iterator*)
  fun iter_key = rocksdb_iter_key(x0 : Iterator*, klen : LibC::SizeT*) : LibC::Char*
  fun iter_value = rocksdb_iter_value(x0 : Iterator*, vlen : LibC::SizeT*) : LibC::Char*
  fun iter_get_error = rocksdb_iter_get_error(x0 : Iterator*, errptr : LibC::Char**)
  fun wal_iter_next = rocksdb_wal_iter_next(iter : WalIterator*)
  fun wal_iter_valid = rocksdb_wal_iter_valid(x0 : WalIterator*) : UInt8
  fun wal_iter_status = rocksdb_wal_iter_status(iter : WalIterator*, errptr : LibC::Char**)
  fun wal_iter_get_batch = rocksdb_wal_iter_get_batch(iter : WalIterator*, seq : UInt64*) : WriteBatch*
  fun get_latest_sequence_number = rocksdb_get_latest_sequence_number(db : Db*) : UInt64*
  fun wal_iter_destroy = rocksdb_wal_iter_destroy(iter : WalIterator*)
  fun writebatch_create = rocksdb_writebatch_create : WriteBatch*
  fun writebatch_create_from = rocksdb_writebatch_create_from(rep : LibC::Char*, size : LibC::SizeT) : WriteBatch*
  fun writebatch_destroy = rocksdb_writebatch_destroy(x0 : WriteBatch*)
  fun writebatch_clear = rocksdb_writebatch_clear(x0 : WriteBatch*)
  fun writebatch_count = rocksdb_writebatch_count(x0 : WriteBatch*) : LibC::Int
  fun writebatch_put = rocksdb_writebatch_put(x0 : WriteBatch*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT)
  fun writebatch_put_cf = rocksdb_writebatch_put_cf(x0 : WriteBatch*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT)
  fun writebatch_putv = rocksdb_writebatch_putv(b : WriteBatch*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, num_values : LibC::Int, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*)
  fun writebatch_putv_cf = rocksdb_writebatch_putv_cf(b : WriteBatch*, column_family : ColumnFamilyHandle*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, num_values : LibC::Int, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*)
  fun writebatch_merge = rocksdb_writebatch_merge(x0 : WriteBatch*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT)
  fun writebatch_merge_cf = rocksdb_writebatch_merge_cf(x0 : WriteBatch*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT)
  fun writebatch_mergev = rocksdb_writebatch_mergev(b : WriteBatch*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, num_values : LibC::Int, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*)
  fun writebatch_mergev_cf = rocksdb_writebatch_mergev_cf(b : WriteBatch*, column_family : ColumnFamilyHandle*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, num_values : LibC::Int, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*)
  fun writebatch_delete = rocksdb_writebatch_delete(x0 : WriteBatch*, key : LibC::Char*, klen : LibC::SizeT)
  fun writebatch_delete_cf = rocksdb_writebatch_delete_cf(x0 : WriteBatch*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT)
  fun writebatch_deletev = rocksdb_writebatch_deletev(b : WriteBatch*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*)
  fun writebatch_deletev_cf = rocksdb_writebatch_deletev_cf(b : WriteBatch*, column_family : ColumnFamilyHandle*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*)
  fun writebatch_delete_range = rocksdb_writebatch_delete_range(b : WriteBatch*, start_key : LibC::Char*, start_key_len : LibC::SizeT, end_key : LibC::Char*, end_key_len : LibC::SizeT)
  fun writebatch_delete_range_cf = rocksdb_writebatch_delete_range_cf(b : WriteBatch*, column_family : ColumnFamilyHandle*, start_key : LibC::Char*, start_key_len : LibC::SizeT, end_key : LibC::Char*, end_key_len : LibC::SizeT)
  fun writebatch_delete_rangev = rocksdb_writebatch_delete_rangev(b : WriteBatch*, num_keys : LibC::Int, start_keys_list : LibC::Char**, start_keys_list_sizes : LibC::SizeT*, end_keys_list : LibC::Char**, end_keys_list_sizes : LibC::SizeT*)
  fun writebatch_delete_rangev_cf = rocksdb_writebatch_delete_rangev_cf(b : WriteBatch*, column_family : ColumnFamilyHandle*, num_keys : LibC::Int, start_keys_list : LibC::Char**, start_keys_list_sizes : LibC::SizeT*, end_keys_list : LibC::Char**, end_keys_list_sizes : LibC::SizeT*)
  fun writebatch_put_log_data = rocksdb_writebatch_put_log_data(x0 : WriteBatch*, blob : LibC::Char*, len : LibC::SizeT)
  fun writebatch_iterate = rocksdb_writebatch_iterate(x0 : WriteBatch*, state : Void*, put : (Void*, LibC::Char*, LibC::SizeT, LibC::Char*, LibC::SizeT -> Void), deleted : (Void*, LibC::Char*, LibC::SizeT -> Void))
  fun writebatch_data = rocksdb_writebatch_data(x0 : WriteBatch*, size : LibC::SizeT*) : LibC::Char*
  fun writebatch_set_save_point = rocksdb_writebatch_set_save_point(x0 : WriteBatch*)
  fun writebatch_rollback_to_save_point = rocksdb_writebatch_rollback_to_save_point(x0 : WriteBatch*, errptr : LibC::Char**)
  fun writebatch_pop_save_point = rocksdb_writebatch_pop_save_point(x0 : WriteBatch*, errptr : LibC::Char**)
  fun writebatch_wi_create = rocksdb_writebatch_wi_create(reserved_bytes : LibC::SizeT, overwrite_keys : UInt8) : WriteBatchWi*
  fun writebatch_wi_create_from = rocksdb_writebatch_wi_create_from(rep : LibC::Char*, size : LibC::SizeT) : WriteBatchWi*
  fun writebatch_wi_destroy = rocksdb_writebatch_wi_destroy(x0 : WriteBatchWi*)
  fun writebatch_wi_clear = rocksdb_writebatch_wi_clear(x0 : WriteBatchWi*)
  fun writebatch_wi_count = rocksdb_writebatch_wi_count(b : WriteBatchWi*) : LibC::Int
  fun writebatch_wi_put = rocksdb_writebatch_wi_put(x0 : WriteBatchWi*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT)
  fun writebatch_wi_put_cf = rocksdb_writebatch_wi_put_cf(x0 : WriteBatchWi*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT)
  fun writebatch_wi_putv = rocksdb_writebatch_wi_putv(b : WriteBatchWi*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, num_values : LibC::Int, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*)
  fun writebatch_wi_putv_cf = rocksdb_writebatch_wi_putv_cf(b : WriteBatchWi*, column_family : ColumnFamilyHandle*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, num_values : LibC::Int, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*)
  fun writebatch_wi_merge = rocksdb_writebatch_wi_merge(x0 : WriteBatchWi*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT)
  fun writebatch_wi_merge_cf = rocksdb_writebatch_wi_merge_cf(x0 : WriteBatchWi*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT)
  fun writebatch_wi_mergev = rocksdb_writebatch_wi_mergev(b : WriteBatchWi*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, num_values : LibC::Int, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*)
  fun writebatch_wi_mergev_cf = rocksdb_writebatch_wi_mergev_cf(b : WriteBatchWi*, column_family : ColumnFamilyHandle*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*, num_values : LibC::Int, values_list : LibC::Char**, values_list_sizes : LibC::SizeT*)
  fun writebatch_wi_delete = rocksdb_writebatch_wi_delete(x0 : WriteBatchWi*, key : LibC::Char*, klen : LibC::SizeT)
  fun writebatch_wi_delete_cf = rocksdb_writebatch_wi_delete_cf(x0 : WriteBatchWi*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT)
  fun writebatch_wi_deletev = rocksdb_writebatch_wi_deletev(b : WriteBatchWi*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*)
  fun writebatch_wi_deletev_cf = rocksdb_writebatch_wi_deletev_cf(b : WriteBatchWi*, column_family : ColumnFamilyHandle*, num_keys : LibC::Int, keys_list : LibC::Char**, keys_list_sizes : LibC::SizeT*)
  fun writebatch_wi_delete_range = rocksdb_writebatch_wi_delete_range(b : WriteBatchWi*, start_key : LibC::Char*, start_key_len : LibC::SizeT, end_key : LibC::Char*, end_key_len : LibC::SizeT)
  fun writebatch_wi_delete_range_cf = rocksdb_writebatch_wi_delete_range_cf(b : WriteBatchWi*, column_family : ColumnFamilyHandle*, start_key : LibC::Char*, start_key_len : LibC::SizeT, end_key : LibC::Char*, end_key_len : LibC::SizeT)
  fun writebatch_wi_delete_rangev = rocksdb_writebatch_wi_delete_rangev(b : WriteBatchWi*, num_keys : LibC::Int, start_keys_list : LibC::Char**, start_keys_list_sizes : LibC::SizeT*, end_keys_list : LibC::Char**, end_keys_list_sizes : LibC::SizeT*)
  fun writebatch_wi_delete_rangev_cf = rocksdb_writebatch_wi_delete_rangev_cf(b : WriteBatchWi*, column_family : ColumnFamilyHandle*, num_keys : LibC::Int, start_keys_list : LibC::Char**, start_keys_list_sizes : LibC::SizeT*, end_keys_list : LibC::Char**, end_keys_list_sizes : LibC::SizeT*)
  fun writebatch_wi_put_log_data = rocksdb_writebatch_wi_put_log_data(x0 : WriteBatchWi*, blob : LibC::Char*, len : LibC::SizeT)
  fun writebatch_wi_iterate = rocksdb_writebatch_wi_iterate(b : WriteBatchWi*, state : Void*, put : (Void*, LibC::Char*, LibC::SizeT, LibC::Char*, LibC::SizeT -> Void), deleted : (Void*, LibC::Char*, LibC::SizeT -> Void))
  fun writebatch_wi_data = rocksdb_writebatch_wi_data(b : WriteBatchWi*, size : LibC::SizeT*) : LibC::Char*
  fun writebatch_wi_set_save_point = rocksdb_writebatch_wi_set_save_point(x0 : WriteBatchWi*)
  fun writebatch_wi_rollback_to_save_point = rocksdb_writebatch_wi_rollback_to_save_point(x0 : WriteBatchWi*, errptr : LibC::Char**)
  fun writebatch_wi_get_from_batch = rocksdb_writebatch_wi_get_from_batch(wbwi : WriteBatchWi*, options : Options*, key : LibC::Char*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun writebatch_wi_get_from_batch_cf = rocksdb_writebatch_wi_get_from_batch_cf(wbwi : WriteBatchWi*, options : Options*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun writebatch_wi_get_from_batch_and_db = rocksdb_writebatch_wi_get_from_batch_and_db(wbwi : WriteBatchWi*, db : Db*, options : ReadOptions*, key : LibC::Char*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun writebatch_wi_get_from_batch_and_db_cf = rocksdb_writebatch_wi_get_from_batch_and_db_cf(wbwi : WriteBatchWi*, db : Db*, options : ReadOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun write_writebatch_wi = rocksdb_write_writebatch_wi(db : Db*, options : WriteOptions*, wbwi : WriteBatchWi*, errptr : LibC::Char**)
  fun writebatch_wi_create_iterator_with_base = rocksdb_writebatch_wi_create_iterator_with_base(wbwi : WriteBatchWi*, base_iterator : Iterator*) : Iterator*
  fun writebatch_wi_create_iterator_with_base_cf = rocksdb_writebatch_wi_create_iterator_with_base_cf(wbwi : WriteBatchWi*, base_iterator : Iterator*, cf : ColumnFamilyHandle*) : Iterator*
  fun block_based_options_create = rocksdb_block_based_options_create : BlockBasedTableOptions*
  fun block_based_options_destroy = rocksdb_block_based_options_destroy(options : BlockBasedTableOptions*)
  fun block_based_options_set_block_size = rocksdb_block_based_options_set_block_size(options : BlockBasedTableOptions*, block_size : LibC::SizeT)
  fun block_based_options_set_block_size_deviation = rocksdb_block_based_options_set_block_size_deviation(options : BlockBasedTableOptions*, block_size_deviation : LibC::Int)
  fun block_based_options_set_block_restart_interval = rocksdb_block_based_options_set_block_restart_interval(options : BlockBasedTableOptions*, block_restart_interval : LibC::Int)
  fun block_based_options_set_index_block_restart_interval = rocksdb_block_based_options_set_index_block_restart_interval(options : BlockBasedTableOptions*, index_block_restart_interval : LibC::Int)
  fun block_based_options_set_metadata_block_size = rocksdb_block_based_options_set_metadata_block_size(options : BlockBasedTableOptions*, metadata_block_size : UInt64)
  fun block_based_options_set_partition_filters = rocksdb_block_based_options_set_partition_filters(options : BlockBasedTableOptions*, partition_filters : UInt8)
  fun block_based_options_set_use_delta_encoding = rocksdb_block_based_options_set_use_delta_encoding(options : BlockBasedTableOptions*, use_delta_encoding : UInt8)
  fun block_based_options_set_filter_policy = rocksdb_block_based_options_set_filter_policy(options : BlockBasedTableOptions*, filter_policy : FilterPolicy*)
  fun block_based_options_set_no_block_cache = rocksdb_block_based_options_set_no_block_cache(options : BlockBasedTableOptions*, no_block_cache : UInt8)
  fun block_based_options_set_block_cache = rocksdb_block_based_options_set_block_cache(options : BlockBasedTableOptions*, block_cache : Cache*)
  fun block_based_options_set_block_cache_compressed = rocksdb_block_based_options_set_block_cache_compressed(options : BlockBasedTableOptions*, block_cache_compressed : Cache*)
  fun block_based_options_set_whole_key_filtering = rocksdb_block_based_options_set_whole_key_filtering(x0 : BlockBasedTableOptions*, x1 : UInt8)
  fun block_based_options_set_format_version = rocksdb_block_based_options_set_format_version(x0 : BlockBasedTableOptions*, x1 : LibC::Int)
  BlockBasedTableIndexTypeBinarySearch        = 0_i64
  BlockBasedTableIndexTypeHashSearch          = 1_i64
  BlockBasedTableIndexTypeTwoLevelIndexSearch = 2_i64
  fun block_based_options_set_index_type = rocksdb_block_based_options_set_index_type(x0 : BlockBasedTableOptions*, x1 : LibC::Int)
  fun block_based_options_set_hash_index_allow_collision = rocksdb_block_based_options_set_hash_index_allow_collision(x0 : BlockBasedTableOptions*, x1 : UInt8)
  fun block_based_options_set_cache_index_and_filter_blocks = rocksdb_block_based_options_set_cache_index_and_filter_blocks(x0 : BlockBasedTableOptions*, x1 : UInt8)
  fun block_based_options_set_cache_index_and_filter_blocks_with_high_priority = rocksdb_block_based_options_set_cache_index_and_filter_blocks_with_high_priority(x0 : BlockBasedTableOptions*, x1 : UInt8)
  fun block_based_options_set_pin_l0_filter_and_index_blocks_in_cache = rocksdb_block_based_options_set_pin_l0_filter_and_index_blocks_in_cache(x0 : BlockBasedTableOptions*, x1 : UInt8)
  fun block_based_options_set_pin_top_level_index_and_filter = rocksdb_block_based_options_set_pin_top_level_index_and_filter(x0 : BlockBasedTableOptions*, x1 : UInt8)
  fun options_set_block_based_table_factory = rocksdb_options_set_block_based_table_factory(opt : Options*, table_options : BlockBasedTableOptions*)
  fun cuckoo_options_create = rocksdb_cuckoo_options_create : CuckooTableOptions*
  fun cuckoo_options_destroy = rocksdb_cuckoo_options_destroy(options : CuckooTableOptions*)
  fun cuckoo_options_set_hash_ratio = rocksdb_cuckoo_options_set_hash_ratio(options : CuckooTableOptions*, v : LibC::Double)
  fun cuckoo_options_set_max_search_depth = rocksdb_cuckoo_options_set_max_search_depth(options : CuckooTableOptions*, v : UInt32)
  fun cuckoo_options_set_cuckoo_block_size = rocksdb_cuckoo_options_set_cuckoo_block_size(options : CuckooTableOptions*, v : UInt32)
  fun cuckoo_options_set_identity_as_first_hash = rocksdb_cuckoo_options_set_identity_as_first_hash(options : CuckooTableOptions*, v : UInt8)
  fun cuckoo_options_set_use_module_hash = rocksdb_cuckoo_options_set_use_module_hash(options : CuckooTableOptions*, v : UInt8)
  fun options_set_cuckoo_table_factory = rocksdb_options_set_cuckoo_table_factory(opt : Options*, table_options : CuckooTableOptions*)
  fun set_options = rocksdb_set_options(db : Db*, count : LibC::Int, keys : LibC::Char**, values : LibC::Char**, errptr : LibC::Char**)
  fun set_options_cf = rocksdb_set_options_cf(db : Db*, handle : ColumnFamilyHandle*, count : LibC::Int, keys : LibC::Char**, values : LibC::Char**, errptr : LibC::Char**)
  fun options_create = rocksdb_options_create : Options*
  fun options_destroy = rocksdb_options_destroy(x0 : Options*)
  fun options_increase_parallelism = rocksdb_options_increase_parallelism(opt : Options*, total_threads : LibC::Int)
  fun options_optimize_for_point_lookup = rocksdb_options_optimize_for_point_lookup(opt : Options*, block_cache_size_mb : UInt64)
  fun options_optimize_level_style_compaction = rocksdb_options_optimize_level_style_compaction(opt : Options*, memtable_memory_budget : UInt64)
  fun options_optimize_universal_style_compaction = rocksdb_options_optimize_universal_style_compaction(opt : Options*, memtable_memory_budget : UInt64)
  fun options_set_allow_ingest_behind = rocksdb_options_set_allow_ingest_behind(x0 : Options*, x1 : UInt8)
  fun options_set_compaction_filter = rocksdb_options_set_compaction_filter(x0 : Options*, x1 : CompactionFilter*)
  fun options_set_compaction_filter_factory = rocksdb_options_set_compaction_filter_factory(x0 : Options*, x1 : CompactionFilterFactory*)
  fun options_compaction_readahead_size = rocksdb_options_compaction_readahead_size(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_comparator = rocksdb_options_set_comparator(x0 : Options*, x1 : Comparator*)
  fun options_set_merge_operator = rocksdb_options_set_merge_operator(x0 : Options*, x1 : MergeOperator*)
  fun options_set_uint64add_merge_operator = rocksdb_options_set_uint64add_merge_operator(x0 : Options*)
  fun options_set_compression_per_level = rocksdb_options_set_compression_per_level(opt : Options*, level_values : LibC::Int*, num_levels : LibC::SizeT)
  fun options_set_create_if_missing = rocksdb_options_set_create_if_missing(x0 : Options*, x1 : UInt8)
  fun options_set_create_missing_column_families = rocksdb_options_set_create_missing_column_families(x0 : Options*, x1 : UInt8)
  fun options_set_error_if_exists = rocksdb_options_set_error_if_exists(x0 : Options*, x1 : UInt8)
  fun options_set_paranoid_checks = rocksdb_options_set_paranoid_checks(x0 : Options*, x1 : UInt8)
  fun options_set_db_paths = rocksdb_options_set_db_paths(x0 : Options*, path_values : DbPath**, num_paths : LibC::SizeT)
  fun options_set_env = rocksdb_options_set_env(x0 : Options*, x1 : Env*)
  fun options_set_info_log = rocksdb_options_set_info_log(x0 : Options*, x1 : Logger*)
  fun options_set_info_log_level = rocksdb_options_set_info_log_level(x0 : Options*, x1 : LibC::Int)
  fun options_set_write_buffer_size = rocksdb_options_set_write_buffer_size(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_db_write_buffer_size = rocksdb_options_set_db_write_buffer_size(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_max_open_files = rocksdb_options_set_max_open_files(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_file_opening_threads = rocksdb_options_set_max_file_opening_threads(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_total_wal_size = rocksdb_options_set_max_total_wal_size(opt : Options*, n : UInt64)
  fun options_set_compression_options = rocksdb_options_set_compression_options(x0 : Options*, x1 : LibC::Int, x2 : LibC::Int, x3 : LibC::Int, x4 : LibC::Int)
  fun options_set_prefix_extractor = rocksdb_options_set_prefix_extractor(x0 : Options*, x1 : SliceTransform*)
  fun options_set_num_levels = rocksdb_options_set_num_levels(x0 : Options*, x1 : LibC::Int)
  fun options_set_level0_file_num_compaction_trigger = rocksdb_options_set_level0_file_num_compaction_trigger(x0 : Options*, x1 : LibC::Int)
  fun options_set_level0_slowdown_writes_trigger = rocksdb_options_set_level0_slowdown_writes_trigger(x0 : Options*, x1 : LibC::Int)
  fun options_set_level0_stop_writes_trigger = rocksdb_options_set_level0_stop_writes_trigger(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_mem_compaction_level = rocksdb_options_set_max_mem_compaction_level(x0 : Options*, x1 : LibC::Int)
  fun options_set_target_file_size_base = rocksdb_options_set_target_file_size_base(x0 : Options*, x1 : UInt64)
  fun options_set_target_file_size_multiplier = rocksdb_options_set_target_file_size_multiplier(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_bytes_for_level_base = rocksdb_options_set_max_bytes_for_level_base(x0 : Options*, x1 : UInt64)
  fun options_set_snap_refresh_nanos = rocksdb_options_set_snap_refresh_nanos(x0 : Options*, x1 : UInt64)
  fun options_set_level_compaction_dynamic_level_bytes = rocksdb_options_set_level_compaction_dynamic_level_bytes(x0 : Options*, x1 : UInt8)
  fun options_set_max_bytes_for_level_multiplier = rocksdb_options_set_max_bytes_for_level_multiplier(x0 : Options*, x1 : LibC::Double)
  fun options_set_max_bytes_for_level_multiplier_additional = rocksdb_options_set_max_bytes_for_level_multiplier_additional(x0 : Options*, level_values : LibC::Int*, num_levels : LibC::SizeT)
  fun options_enable_statistics = rocksdb_options_enable_statistics(x0 : Options*)
  fun options_set_skip_stats_update_on_db_open = rocksdb_options_set_skip_stats_update_on_db_open(opt : Options*, val : UInt8)
  fun options_statistics_get_string = rocksdb_options_statistics_get_string(opt : Options*) : LibC::Char*
  fun options_set_max_write_buffer_number = rocksdb_options_set_max_write_buffer_number(x0 : Options*, x1 : LibC::Int)
  fun options_set_min_write_buffer_number_to_merge = rocksdb_options_set_min_write_buffer_number_to_merge(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_write_buffer_number_to_maintain = rocksdb_options_set_max_write_buffer_number_to_maintain(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_write_buffer_size_to_maintain = rocksdb_options_set_max_write_buffer_size_to_maintain(x0 : Options*, x1 : Int64)
  fun options_set_enable_pipelined_write = rocksdb_options_set_enable_pipelined_write(x0 : Options*, x1 : UInt8)
  fun options_set_unordered_write = rocksdb_options_set_unordered_write(x0 : Options*, x1 : UInt8)
  fun options_set_max_subcompactions = rocksdb_options_set_max_subcompactions(x0 : Options*, x1 : UInt32)
  fun options_set_max_background_jobs = rocksdb_options_set_max_background_jobs(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_background_compactions = rocksdb_options_set_max_background_compactions(x0 : Options*, x1 : LibC::Int)
  fun options_set_base_background_compactions = rocksdb_options_set_base_background_compactions(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_background_flushes = rocksdb_options_set_max_background_flushes(x0 : Options*, x1 : LibC::Int)
  fun options_set_max_log_file_size = rocksdb_options_set_max_log_file_size(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_log_file_time_to_roll = rocksdb_options_set_log_file_time_to_roll(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_keep_log_file_num = rocksdb_options_set_keep_log_file_num(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_recycle_log_file_num = rocksdb_options_set_recycle_log_file_num(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_soft_rate_limit = rocksdb_options_set_soft_rate_limit(x0 : Options*, x1 : LibC::Double)
  fun options_set_hard_rate_limit = rocksdb_options_set_hard_rate_limit(x0 : Options*, x1 : LibC::Double)
  fun options_set_soft_pending_compaction_bytes_limit = rocksdb_options_set_soft_pending_compaction_bytes_limit(opt : Options*, v : LibC::SizeT)
  fun options_set_hard_pending_compaction_bytes_limit = rocksdb_options_set_hard_pending_compaction_bytes_limit(opt : Options*, v : LibC::SizeT)
  fun options_set_rate_limit_delay_max_milliseconds = rocksdb_options_set_rate_limit_delay_max_milliseconds(x0 : Options*, x1 : LibC::UInt)
  fun options_set_max_manifest_file_size = rocksdb_options_set_max_manifest_file_size(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_table_cache_numshardbits = rocksdb_options_set_table_cache_numshardbits(x0 : Options*, x1 : LibC::Int)
  fun options_set_table_cache_remove_scan_count_limit = rocksdb_options_set_table_cache_remove_scan_count_limit(x0 : Options*, x1 : LibC::Int)
  fun options_set_arena_block_size = rocksdb_options_set_arena_block_size(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_use_fsync = rocksdb_options_set_use_fsync(x0 : Options*, x1 : LibC::Int)
  fun options_set_db_log_dir = rocksdb_options_set_db_log_dir(x0 : Options*, x1 : LibC::Char*)
  fun options_set_wal_dir = rocksdb_options_set_wal_dir(x0 : Options*, x1 : LibC::Char*)
  fun options_set_wal_ttl_seconds = rocksdb_options_set_WAL_ttl_seconds(x0 : Options*, x1 : UInt64)
  fun options_set_wal_size_limit_mb = rocksdb_options_set_WAL_size_limit_MB(x0 : Options*, x1 : UInt64)
  fun options_set_manifest_preallocation_size = rocksdb_options_set_manifest_preallocation_size(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_purge_redundant_kvs_while_flush = rocksdb_options_set_purge_redundant_kvs_while_flush(x0 : Options*, x1 : UInt8)
  fun options_set_allow_mmap_reads = rocksdb_options_set_allow_mmap_reads(x0 : Options*, x1 : UInt8)
  fun options_set_allow_mmap_writes = rocksdb_options_set_allow_mmap_writes(x0 : Options*, x1 : UInt8)
  fun options_set_use_direct_reads = rocksdb_options_set_use_direct_reads(x0 : Options*, x1 : UInt8)
  fun options_set_use_direct_io_for_flush_and_compaction = rocksdb_options_set_use_direct_io_for_flush_and_compaction(x0 : Options*, x1 : UInt8)
  fun options_set_is_fd_close_on_exec = rocksdb_options_set_is_fd_close_on_exec(x0 : Options*, x1 : UInt8)
  fun options_set_skip_log_error_on_recovery = rocksdb_options_set_skip_log_error_on_recovery(x0 : Options*, x1 : UInt8)
  fun options_set_stats_dump_period_sec = rocksdb_options_set_stats_dump_period_sec(x0 : Options*, x1 : LibC::UInt)
  fun options_set_advise_random_on_open = rocksdb_options_set_advise_random_on_open(x0 : Options*, x1 : UInt8)
  fun options_set_access_hint_on_compaction_start = rocksdb_options_set_access_hint_on_compaction_start(x0 : Options*, x1 : LibC::Int)
  fun options_set_use_adaptive_mutex = rocksdb_options_set_use_adaptive_mutex(x0 : Options*, x1 : UInt8)
  fun options_set_bytes_per_sync = rocksdb_options_set_bytes_per_sync(x0 : Options*, x1 : UInt64)
  fun options_set_wal_bytes_per_sync = rocksdb_options_set_wal_bytes_per_sync(x0 : Options*, x1 : UInt64)
  fun options_set_writable_file_max_buffer_size = rocksdb_options_set_writable_file_max_buffer_size(x0 : Options*, x1 : UInt64)
  fun options_set_allow_concurrent_memtable_write = rocksdb_options_set_allow_concurrent_memtable_write(x0 : Options*, x1 : UInt8)
  fun options_set_enable_write_thread_adaptive_yield = rocksdb_options_set_enable_write_thread_adaptive_yield(x0 : Options*, x1 : UInt8)
  fun options_set_max_sequential_skip_in_iterations = rocksdb_options_set_max_sequential_skip_in_iterations(x0 : Options*, x1 : UInt64)
  fun options_set_disable_auto_compactions = rocksdb_options_set_disable_auto_compactions(x0 : Options*, x1 : LibC::Int)
  fun options_set_optimize_filters_for_hits = rocksdb_options_set_optimize_filters_for_hits(x0 : Options*, x1 : LibC::Int)
  fun options_set_delete_obsolete_files_period_micros = rocksdb_options_set_delete_obsolete_files_period_micros(x0 : Options*, x1 : UInt64)
  fun options_prepare_for_bulk_load = rocksdb_options_prepare_for_bulk_load(x0 : Options*)
  fun options_set_memtable_vector_rep = rocksdb_options_set_memtable_vector_rep(x0 : Options*)
  fun options_set_memtable_prefix_bloom_size_ratio = rocksdb_options_set_memtable_prefix_bloom_size_ratio(x0 : Options*, x1 : LibC::Double)
  fun options_set_max_compaction_bytes = rocksdb_options_set_max_compaction_bytes(x0 : Options*, x1 : UInt64)
  fun options_set_hash_skip_list_rep = rocksdb_options_set_hash_skip_list_rep(x0 : Options*, x1 : LibC::SizeT, x2 : Int32*, x3 : Int32*)
  fun options_set_hash_link_list_rep = rocksdb_options_set_hash_link_list_rep(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_plain_table_factory = rocksdb_options_set_plain_table_factory(x0 : Options*, x1 : UInt32, x2 : LibC::Int, x3 : LibC::Double, x4 : LibC::SizeT)
  fun options_set_min_level_to_compress = rocksdb_options_set_min_level_to_compress(opt : Options*, level : LibC::Int)
  fun options_set_memtable_huge_page_size = rocksdb_options_set_memtable_huge_page_size(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_max_successive_merges = rocksdb_options_set_max_successive_merges(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_bloom_locality = rocksdb_options_set_bloom_locality(x0 : Options*, x1 : UInt32)
  fun options_set_inplace_update_support = rocksdb_options_set_inplace_update_support(x0 : Options*, x1 : UInt8)
  fun options_set_inplace_update_num_locks = rocksdb_options_set_inplace_update_num_locks(x0 : Options*, x1 : LibC::SizeT)
  fun options_set_report_bg_io_stats = rocksdb_options_set_report_bg_io_stats(x0 : Options*, x1 : LibC::Int)
  TolerateCorruptedTailRecordsRecovery = 0_i64
  AbsoluteConsistencyRecovery = 1_i64
  PointInTimeRecovery = 2_i64
  SkipAnyCorruptedRecordsRecovery = 3_i64
  fun options_set_wal_recovery_mode = rocksdb_options_set_wal_recovery_mode(x0 : Options*, x1 : LibC::Int)
  NoCompression = 0_i64
  SnappyCompression = 1_i64
  ZlibCompression = 2_i64
  Bz2Compression = 3_i64
  Lz4Compression = 4_i64
  Lz4hcCompression = 5_i64
  XpressCompression = 6_i64
  ZstdCompression = 7_i64
  fun options_set_compression = rocksdb_options_set_compression(x0 : Options*, x1 : LibC::Int)
  LevelCompaction = 0_i64
  UniversalCompaction = 1_i64
  FifoCompaction = 2_i64
  fun options_set_compaction_style = rocksdb_options_set_compaction_style(x0 : Options*, x1 : LibC::Int)
  fun options_set_universal_compaction_options = rocksdb_options_set_universal_compaction_options(x0 : Options*, x1 : UniversalCompactionOptions*)
  fun options_set_fifo_compaction_options = rocksdb_options_set_fifo_compaction_options(opt : Options*, fifo : FifoCompactionOptions*)
  fun options_set_ratelimiter = rocksdb_options_set_ratelimiter(opt : Options*, limiter : RateLimiter*)
  fun ratelimiter_create = rocksdb_ratelimiter_create(rate_bytes_per_sec : Int64*, refill_period_us : Int64*, fairness : Int32*) : RateLimiter*
  fun ratelimiter_destroy = rocksdb_ratelimiter_destroy(x0 : RateLimiter*)
  Uninitialized = 0_i64
  Disable = 1_i64
  EnableCount = 2_i64
  EnableTimeExceptForMutex = 3_i64
  EnableTime = 4_i64
  OutOfBounds = 5_i64
  UserKeyComparisonCount = 0_i64
  BlockCacheHitCount = 1_i64
  BlockReadCount = 2_i64
  BlockReadByte = 3_i64
  BlockReadTime = 4_i64
  BlockChecksumTime = 5_i64
  BlockDecompressTime = 6_i64
  GetReadBytes = 7_i64
  MultigetReadBytes = 8_i64
  IterReadBytes = 9_i64
  InternalKeySkippedCount = 10_i64
  InternalDeleteSkippedCount = 11_i64
  InternalRecentSkippedCount = 12_i64
  InternalMergeCount = 13_i64
  GetSnapshotTime = 14_i64
  GetFromMemtableTime = 15_i64
  GetFromMemtableCount = 16_i64
  GetPostProcessTime = 17_i64
  GetFromOutputFilesTime = 18_i64
  SeekOnMemtableTime = 19_i64
  SeekOnMemtableCount = 20_i64
  NextOnMemtableCount = 21_i64
  PrevOnMemtableCount = 22_i64
  SeekChildSeekTime = 23_i64
  SeekChildSeekCount = 24_i64
  SeekMinHeapTime = 25_i64
  SeekMaxHeapTime = 26_i64
  SeekInternalSeekTime = 27_i64
  FindNextUserEntryTime = 28_i64
  WriteWalTime = 29_i64
  WriteMemtableTime = 30_i64
  WriteDelayTime = 31_i64
  WritePreAndPostProcessTime = 32_i64
  DbMutexLockNanos = 33_i64
  DbConditionWaitNanos = 34_i64
  MergeOperatorTimeNanos = 35_i64
  ReadIndexBlockNanos = 36_i64
  ReadFilterBlockNanos = 37_i64
  NewTableBlockIterNanos = 38_i64
  NewTableIteratorNanos = 39_i64
  BlockSeekNanos = 40_i64
  FindTableNanos = 41_i64
  BloomMemtableHitCount = 42_i64
  BloomMemtableMissCount = 43_i64
  BloomSstHitCount = 44_i64
  BloomSstMissCount = 45_i64
  KeyLockWaitTime = 46_i64
  KeyLockWaitCount = 47_i64
  EnvNewSequentialFileNanos = 48_i64
  EnvNewRandomAccessFileNanos = 49_i64
  EnvNewWritableFileNanos = 50_i64
  EnvReuseWritableFileNanos = 51_i64
  EnvNewRandomRwFileNanos = 52_i64
  EnvNewDirectoryNanos = 53_i64
  EnvFileExistsNanos = 54_i64
  EnvGetChildrenNanos = 55_i64
  EnvGetChildrenFileAttributesNanos = 56_i64
  EnvDeleteFileNanos = 57_i64
  EnvCreateDirNanos = 58_i64
  EnvCreateDirIfMissingNanos = 59_i64
  EnvDeleteDirNanos = 60_i64
  EnvGetFileSizeNanos = 61_i64
  EnvGetFileModificationTimeNanos = 62_i64
  EnvRenameFileNanos = 63_i64
  EnvLinkFileNanos = 64_i64
  EnvLockFileNanos = 65_i64
  EnvUnlockFileNanos = 66_i64
  EnvNewLoggerNanos = 67_i64
  TotalMetricCount = 68_i64
  fun set_perf_level = rocksdb_set_perf_level(x0 : LibC::Int)
  fun perfcontext_create = rocksdb_perfcontext_create : PerfContext*
  fun perfcontext_reset = rocksdb_perfcontext_reset(context : PerfContext*)
  fun perfcontext_report = rocksdb_perfcontext_report(context : PerfContext*, exclude_zero_counters : UInt8) : LibC::Char*
  fun perfcontext_metric = rocksdb_perfcontext_metric(context : PerfContext*, metric : LibC::Int) : UInt64*
  fun perfcontext_destroy = rocksdb_perfcontext_destroy(context : PerfContext*)
  fun compactionfilter_create = rocksdb_compactionfilter_create(state : Void*, destructor : (Void* -> Void), filter : (Void*, LibC::Int, LibC::Char*, LibC::SizeT, LibC::Char*, LibC::SizeT, LibC::Char**, LibC::SizeT*, UInt8* -> UInt8), name : (Void* -> LibC::Char*)) : CompactionFilter*
  fun compactionfilter_set_ignore_snapshots = rocksdb_compactionfilter_set_ignore_snapshots(x0 : CompactionFilter*, x1 : UInt8)
  fun compactionfilter_destroy = rocksdb_compactionfilter_destroy(x0 : CompactionFilter*)
  fun compactionfiltercontext_is_full_compaction = rocksdb_compactionfiltercontext_is_full_compaction(context : CompactionFilterContext*) : UInt8
  fun compactionfiltercontext_is_manual_compaction = rocksdb_compactionfiltercontext_is_manual_compaction(context : CompactionFilterContext*) : UInt8
  fun compactionfilterfactory_create = rocksdb_compactionfilterfactory_create(state : Void*, destructor : (Void* -> Void), create_compaction_filter : (Void*, CompactionFilterContext* -> CompactionFilter*), name : (Void* -> LibC::Char*)) : CompactionFilterFactory*
  fun compactionfilterfactory_destroy = rocksdb_compactionfilterfactory_destroy(x0 : CompactionFilterFactory*)
  fun comparator_create = rocksdb_comparator_create(state : Void*, destructor : (Void* -> Void), compare : (Void*, LibC::Char*, LibC::SizeT, LibC::Char*, LibC::SizeT -> LibC::Int), name : (Void* -> LibC::Char*)) : Comparator*
  fun comparator_destroy = rocksdb_comparator_destroy(x0 : Comparator*)
  fun filterpolicy_create = rocksdb_filterpolicy_create(state : Void*, destructor : (Void* -> Void), create_filter : (Void*, LibC::Char**, LibC::SizeT*, LibC::Int, LibC::SizeT* -> LibC::Char*), key_may_match : (Void*, LibC::Char*, LibC::SizeT, LibC::Char*, LibC::SizeT -> UInt8), delete_filter : (Void*, LibC::Char*, LibC::SizeT -> Void), name : (Void* -> LibC::Char*)) : FilterPolicy*
  fun filterpolicy_destroy = rocksdb_filterpolicy_destroy(x0 : FilterPolicy*)
  fun filterpolicy_create_bloom = rocksdb_filterpolicy_create_bloom(bits_per_key : LibC::Int) : FilterPolicy*
  fun filterpolicy_create_bloom_full = rocksdb_filterpolicy_create_bloom_full(bits_per_key : LibC::Int) : FilterPolicy*
  fun mergeoperator_create = rocksdb_mergeoperator_create(state : Void*, destructor : (Void* -> Void), full_merge : (Void*, LibC::Char*, LibC::SizeT, LibC::Char*, LibC::SizeT, LibC::Char**, LibC::SizeT*, LibC::Int, UInt8*, LibC::SizeT* -> LibC::Char*), partial_merge : (Void*, LibC::Char*, LibC::SizeT, LibC::Char**, LibC::SizeT*, LibC::Int, UInt8*, LibC::SizeT* -> LibC::Char*), delete_value : (Void*, LibC::Char*, LibC::SizeT -> Void), name : (Void* -> LibC::Char*)) : MergeOperator*
  fun mergeoperator_destroy = rocksdb_mergeoperator_destroy(x0 : MergeOperator*)
  fun readoptions_create = rocksdb_readoptions_create : ReadOptions*
  fun readoptions_destroy = rocksdb_readoptions_destroy(x0 : ReadOptions*)
  fun readoptions_set_verify_checksums = rocksdb_readoptions_set_verify_checksums(x0 : ReadOptions*, x1 : UInt8)
  fun readoptions_set_fill_cache = rocksdb_readoptions_set_fill_cache(x0 : ReadOptions*, x1 : UInt8)
  fun readoptions_set_iterate_upper_bound = rocksdb_readoptions_set_iterate_upper_bound(x0 : ReadOptions*, key : LibC::Char*, keylen : LibC::SizeT)
  fun readoptions_set_iterate_lower_bound = rocksdb_readoptions_set_iterate_lower_bound(x0 : ReadOptions*, key : LibC::Char*, keylen : LibC::SizeT)
  fun readoptions_set_read_tier = rocksdb_readoptions_set_read_tier(x0 : ReadOptions*, x1 : LibC::Int)
  fun readoptions_set_tailing = rocksdb_readoptions_set_tailing(x0 : ReadOptions*, x1 : UInt8)
  fun readoptions_set_managed = rocksdb_readoptions_set_managed(x0 : ReadOptions*, x1 : UInt8)
  fun readoptions_set_readahead_size = rocksdb_readoptions_set_readahead_size(x0 : ReadOptions*, x1 : LibC::SizeT)
  fun readoptions_set_prefix_same_as_start = rocksdb_readoptions_set_prefix_same_as_start(x0 : ReadOptions*, x1 : UInt8)
  fun readoptions_set_pin_data = rocksdb_readoptions_set_pin_data(x0 : ReadOptions*, x1 : UInt8)
  fun readoptions_set_total_order_seek = rocksdb_readoptions_set_total_order_seek(x0 : ReadOptions*, x1 : UInt8)
  fun readoptions_set_max_skippable_internal_keys = rocksdb_readoptions_set_max_skippable_internal_keys(x0 : ReadOptions*, x1 : UInt64)
  fun readoptions_set_background_purge_on_iterator_cleanup = rocksdb_readoptions_set_background_purge_on_iterator_cleanup(x0 : ReadOptions*, x1 : UInt8)
  fun readoptions_set_ignore_range_deletions = rocksdb_readoptions_set_ignore_range_deletions(x0 : ReadOptions*, x1 : UInt8)
  fun writeoptions_create = rocksdb_writeoptions_create : WriteOptions*
  fun writeoptions_destroy = rocksdb_writeoptions_destroy(x0 : WriteOptions*)
  fun writeoptions_set_sync = rocksdb_writeoptions_set_sync(x0 : WriteOptions*, x1 : UInt8)
  fun writeoptions_disable_wal = rocksdb_writeoptions_disable_WAL(opt : WriteOptions*, disable : LibC::Int)
  fun writeoptions_set_ignore_missing_column_families = rocksdb_writeoptions_set_ignore_missing_column_families(x0 : WriteOptions*, x1 : UInt8)
  fun writeoptions_set_no_slowdown = rocksdb_writeoptions_set_no_slowdown(x0 : WriteOptions*, x1 : UInt8)
  fun writeoptions_set_low_pri = rocksdb_writeoptions_set_low_pri(x0 : WriteOptions*, x1 : UInt8)
  fun writeoptions_set_memtable_insert_hint_per_batch = rocksdb_writeoptions_set_memtable_insert_hint_per_batch(x0 : WriteOptions*, x1 : UInt8)
  fun compactoptions_create = rocksdb_compactoptions_create : CompactOptions*
  fun compactoptions_destroy = rocksdb_compactoptions_destroy(x0 : CompactOptions*)
  fun compactoptions_set_exclusive_manual_compaction = rocksdb_compactoptions_set_exclusive_manual_compaction(x0 : CompactOptions*, x1 : UInt8)
  fun compactoptions_set_bottommost_level_compaction = rocksdb_compactoptions_set_bottommost_level_compaction(x0 : CompactOptions*, x1 : UInt8)
  fun compactoptions_set_change_level = rocksdb_compactoptions_set_change_level(x0 : CompactOptions*, x1 : UInt8)
  fun compactoptions_set_target_level = rocksdb_compactoptions_set_target_level(x0 : CompactOptions*, x1 : LibC::Int)
  fun flushoptions_create = rocksdb_flushoptions_create : FlushOptions*
  fun flushoptions_destroy = rocksdb_flushoptions_destroy(x0 : FlushOptions*)
  fun flushoptions_set_wait = rocksdb_flushoptions_set_wait(x0 : FlushOptions*, x1 : UInt8)
  fun cache_create_lru = rocksdb_cache_create_lru(capacity : LibC::SizeT) : Cache*
  fun cache_destroy = rocksdb_cache_destroy(cache : Cache*)
  fun cache_set_capacity = rocksdb_cache_set_capacity(cache : Cache*, capacity : LibC::SizeT)
  fun cache_get_usage = rocksdb_cache_get_usage(cache : Cache*) : LibC::SizeT
  fun cache_get_pinned_usage = rocksdb_cache_get_pinned_usage(cache : Cache*) : LibC::SizeT
  fun dbpath_create = rocksdb_dbpath_create(path : LibC::Char*, target_size : UInt64) : DbPath*
  fun dbpath_destroy = rocksdb_dbpath_destroy(x0 : DbPath*)
  fun create_default_env = rocksdb_create_default_env : Env*
  fun create_mem_env = rocksdb_create_mem_env : Env*
  fun env_set_background_threads = rocksdb_env_set_background_threads(env : Env*, n : LibC::Int)
  fun env_set_high_priority_background_threads = rocksdb_env_set_high_priority_background_threads(env : Env*, n : LibC::Int)
  fun env_join_all_threads = rocksdb_env_join_all_threads(env : Env*)
  fun env_lower_thread_pool_io_priority = rocksdb_env_lower_thread_pool_io_priority(env : Env*)
  fun env_lower_high_priority_thread_pool_io_priority = rocksdb_env_lower_high_priority_thread_pool_io_priority(env : Env*)
  fun env_lower_thread_pool_cpu_priority = rocksdb_env_lower_thread_pool_cpu_priority(env : Env*)
  fun env_lower_high_priority_thread_pool_cpu_priority = rocksdb_env_lower_high_priority_thread_pool_cpu_priority(env : Env*)
  fun env_destroy = rocksdb_env_destroy(x0 : Env*)
  fun envoptions_create = rocksdb_envoptions_create : EnvOptions*
  fun envoptions_destroy = rocksdb_envoptions_destroy(opt : EnvOptions*)
  fun sstfilewriter_create = rocksdb_sstfilewriter_create(env : EnvOptions*, io_options : Options*) : SstFileWriter*
  fun sstfilewriter_create_with_comparator = rocksdb_sstfilewriter_create_with_comparator(env : EnvOptions*, io_options : Options*, comparator : Comparator*) : SstFileWriter*
  fun sstfilewriter_open = rocksdb_sstfilewriter_open(writer : SstFileWriter*, name : LibC::Char*, errptr : LibC::Char**)
  fun sstfilewriter_add = rocksdb_sstfilewriter_add(writer : SstFileWriter*, key : LibC::Char*, keylen : LibC::SizeT, val : LibC::Char*, vallen : LibC::SizeT, errptr : LibC::Char**)
  fun sstfilewriter_put = rocksdb_sstfilewriter_put(writer : SstFileWriter*, key : LibC::Char*, keylen : LibC::SizeT, val : LibC::Char*, vallen : LibC::SizeT, errptr : LibC::Char**)
  fun sstfilewriter_merge = rocksdb_sstfilewriter_merge(writer : SstFileWriter*, key : LibC::Char*, keylen : LibC::SizeT, val : LibC::Char*, vallen : LibC::SizeT, errptr : LibC::Char**)
  fun sstfilewriter_delete = rocksdb_sstfilewriter_delete(writer : SstFileWriter*, key : LibC::Char*, keylen : LibC::SizeT, errptr : LibC::Char**)
  fun sstfilewriter_finish = rocksdb_sstfilewriter_finish(writer : SstFileWriter*, errptr : LibC::Char**)
  fun sstfilewriter_file_size = rocksdb_sstfilewriter_file_size(writer : SstFileWriter*, file_size : UInt64*)
  fun sstfilewriter_destroy = rocksdb_sstfilewriter_destroy(writer : SstFileWriter*)
  fun ingestexternalfileoptions_create = rocksdb_ingestexternalfileoptions_create : IngestExternalFileOptions*
  fun ingestexternalfileoptions_set_move_files = rocksdb_ingestexternalfileoptions_set_move_files(opt : IngestExternalFileOptions*, move_files : UInt8)
  fun ingestexternalfileoptions_set_snapshot_consistency = rocksdb_ingestexternalfileoptions_set_snapshot_consistency(opt : IngestExternalFileOptions*, snapshot_consistency : UInt8)
  fun ingestexternalfileoptions_set_allow_global_seqno = rocksdb_ingestexternalfileoptions_set_allow_global_seqno(opt : IngestExternalFileOptions*, allow_global_seqno : UInt8)
  fun ingestexternalfileoptions_set_allow_blocking_flush = rocksdb_ingestexternalfileoptions_set_allow_blocking_flush(opt : IngestExternalFileOptions*, allow_blocking_flush : UInt8)
  fun ingestexternalfileoptions_set_ingest_behind = rocksdb_ingestexternalfileoptions_set_ingest_behind(opt : IngestExternalFileOptions*, ingest_behind : UInt8)
  fun ingestexternalfileoptions_destroy = rocksdb_ingestexternalfileoptions_destroy(opt : IngestExternalFileOptions*)
  fun ingest_external_file = rocksdb_ingest_external_file(db : Db*, file_list : LibC::Char**, list_len : LibC::SizeT, opt : IngestExternalFileOptions*, errptr : LibC::Char**)
  fun ingest_external_file_cf = rocksdb_ingest_external_file_cf(db : Db*, handle : ColumnFamilyHandle*, file_list : LibC::Char**, list_len : LibC::SizeT, opt : IngestExternalFileOptions*, errptr : LibC::Char**)
  fun try_catch_up_with_primary = rocksdb_try_catch_up_with_primary(db : Db*, errptr : LibC::Char**)
  fun slicetransform_create = rocksdb_slicetransform_create(state : Void*, destructor : (Void* -> Void), transform : (Void*, LibC::Char*, LibC::SizeT, LibC::SizeT* -> LibC::Char*), in_domain : (Void*, LibC::Char*, LibC::SizeT -> UInt8), in_range : (Void*, LibC::Char*, LibC::SizeT -> UInt8), name : (Void* -> LibC::Char*)) : SliceTransform*
  fun slicetransform_create_fixed_prefix = rocksdb_slicetransform_create_fixed_prefix(x0 : LibC::SizeT) : SliceTransform*
  fun slicetransform_create_noop = rocksdb_slicetransform_create_noop : SliceTransform*
  fun slicetransform_destroy = rocksdb_slicetransform_destroy(x0 : SliceTransform*)
  SimilarSizeCompactionStopStyle = 0_i64
  TotalSizeCompactionStopStyle = 1_i64
  fun universal_compaction_options_create = rocksdb_universal_compaction_options_create : UniversalCompactionOptions*
  fun universal_compaction_options_set_size_ratio = rocksdb_universal_compaction_options_set_size_ratio(x0 : UniversalCompactionOptions*, x1 : LibC::Int)
  fun universal_compaction_options_set_min_merge_width = rocksdb_universal_compaction_options_set_min_merge_width(x0 : UniversalCompactionOptions*, x1 : LibC::Int)
  fun universal_compaction_options_set_max_merge_width = rocksdb_universal_compaction_options_set_max_merge_width(x0 : UniversalCompactionOptions*, x1 : LibC::Int)
  fun universal_compaction_options_set_max_size_amplification_percent = rocksdb_universal_compaction_options_set_max_size_amplification_percent(x0 : UniversalCompactionOptions*, x1 : LibC::Int)
  fun universal_compaction_options_set_compression_size_percent = rocksdb_universal_compaction_options_set_compression_size_percent(x0 : UniversalCompactionOptions*, x1 : LibC::Int)
  fun universal_compaction_options_set_stop_style = rocksdb_universal_compaction_options_set_stop_style(x0 : UniversalCompactionOptions*, x1 : LibC::Int)
  fun universal_compaction_options_destroy = rocksdb_universal_compaction_options_destroy(x0 : UniversalCompactionOptions*)
  fun fifo_compaction_options_create = rocksdb_fifo_compaction_options_create : FifoCompactionOptions*
  fun fifo_compaction_options_set_max_table_files_size = rocksdb_fifo_compaction_options_set_max_table_files_size(fifo_opts : FifoCompactionOptions*, size : UInt64)
  fun fifo_compaction_options_destroy = rocksdb_fifo_compaction_options_destroy(fifo_opts : FifoCompactionOptions*)
  fun livefiles_count = rocksdb_livefiles_count(x0 : LiveFiles*) : LibC::Int
  fun livefiles_name = rocksdb_livefiles_name(x0 : LiveFiles*, index : LibC::Int) : LibC::Char*
  fun livefiles_level = rocksdb_livefiles_level(x0 : LiveFiles*, index : LibC::Int) : LibC::Int
  fun livefiles_size = rocksdb_livefiles_size(x0 : LiveFiles*, index : LibC::Int) : LibC::SizeT
  fun livefiles_smallestkey = rocksdb_livefiles_smallestkey(x0 : LiveFiles*, index : LibC::Int, size : LibC::SizeT*) : LibC::Char*
  fun livefiles_largestkey = rocksdb_livefiles_largestkey(x0 : LiveFiles*, index : LibC::Int, size : LibC::SizeT*) : LibC::Char*
  fun livefiles_entries = rocksdb_livefiles_entries(x0 : LiveFiles*, index : LibC::Int) : UInt64*
  fun livefiles_deletions = rocksdb_livefiles_deletions(x0 : LiveFiles*, index : LibC::Int) : UInt64*
  fun livefiles_destroy = rocksdb_livefiles_destroy(x0 : LiveFiles*)
  fun get_options_from_string = rocksdb_get_options_from_string(base_options : Options*, opts_str : LibC::Char*, new_options : Options*, errptr : LibC::Char**)
  fun delete_file_in_range = rocksdb_delete_file_in_range(db : Db*, start_key : LibC::Char*, start_key_len : LibC::SizeT, limit_key : LibC::Char*, limit_key_len : LibC::SizeT, errptr : LibC::Char**)
  fun delete_file_in_range_cf = rocksdb_delete_file_in_range_cf(db : Db*, column_family : ColumnFamilyHandle*, start_key : LibC::Char*, start_key_len : LibC::SizeT, limit_key : LibC::Char*, limit_key_len : LibC::SizeT, errptr : LibC::Char**)
  fun transactiondb_create_column_family = rocksdb_transactiondb_create_column_family(txn_db : TransactionDb*, column_family_options : Options*, column_family_name : LibC::Char*, errptr : LibC::Char**) : ColumnFamilyHandle*
  fun transactiondb_open = rocksdb_transactiondb_open(options : Options*, txn_db_options : TransactionDbOptions*, name : LibC::Char*, errptr : LibC::Char**) : TransactionDb*
  fun transactiondb_open_column_families = rocksdb_transactiondb_open_column_families(options : Options*, txn_db_options : TransactionDbOptions*, name : LibC::Char*, num_column_families : LibC::Int, column_family_names : LibC::Char**, column_family_options : Options**, column_family_handles : ColumnFamilyHandle**, errptr : LibC::Char**) : TransactionDb*
  fun transactiondb_create_snapshot = rocksdb_transactiondb_create_snapshot(txn_db : TransactionDb*) : Snapshot*
  fun transactiondb_release_snapshot = rocksdb_transactiondb_release_snapshot(txn_db : TransactionDb*, snapshot : Snapshot*)
  fun transaction_begin = rocksdb_transaction_begin(txn_db : TransactionDb*, write_options : WriteOptions*, txn_options : TransactionOptions*, old_txn : Transaction*) : Transaction*
  fun transaction_commit = rocksdb_transaction_commit(txn : Transaction*, errptr : LibC::Char**)
  fun transaction_rollback = rocksdb_transaction_rollback(txn : Transaction*, errptr : LibC::Char**)
  fun transaction_set_savepoint = rocksdb_transaction_set_savepoint(txn : Transaction*)
  fun transaction_rollback_to_savepoint = rocksdb_transaction_rollback_to_savepoint(txn : Transaction*, errptr : LibC::Char**)
  fun transaction_destroy = rocksdb_transaction_destroy(txn : Transaction*)
  fun transaction_get_snapshot = rocksdb_transaction_get_snapshot(txn : Transaction*) : Snapshot*
  fun transaction_get = rocksdb_transaction_get(txn : Transaction*, options : ReadOptions*, key : LibC::Char*, klen : LibC::SizeT, vlen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun transaction_get_cf = rocksdb_transaction_get_cf(txn : Transaction*, options : ReadOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, vlen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun transaction_get_for_update = rocksdb_transaction_get_for_update(txn : Transaction*, options : ReadOptions*, key : LibC::Char*, klen : LibC::SizeT, vlen : LibC::SizeT*, exclusive : UInt8, errptr : LibC::Char**) : LibC::Char*
  fun transaction_get_for_update_cf = rocksdb_transaction_get_for_update_cf(txn : Transaction*, options : ReadOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, vlen : LibC::SizeT*, exclusive : UInt8, errptr : LibC::Char**) : LibC::Char*
  fun transactiondb_get = rocksdb_transactiondb_get(txn_db : TransactionDb*, options : ReadOptions*, key : LibC::Char*, klen : LibC::SizeT, vlen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun transactiondb_get_cf = rocksdb_transactiondb_get_cf(txn_db : TransactionDb*, options : ReadOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : LibC::Char**) : LibC::Char*
  fun transaction_put = rocksdb_transaction_put(txn : Transaction*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT, errptr : LibC::Char**)
  fun transaction_put_cf = rocksdb_transaction_put_cf(txn : Transaction*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT, errptr : LibC::Char**)
  fun transactiondb_put = rocksdb_transactiondb_put(txn_db : TransactionDb*, options : WriteOptions*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT, errptr : LibC::Char**)
  fun transactiondb_put_cf = rocksdb_transactiondb_put_cf(txn_db : TransactionDb*, options : WriteOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, val : LibC::Char*, vallen : LibC::SizeT, errptr : LibC::Char**)
  fun transactiondb_write = rocksdb_transactiondb_write(txn_db : TransactionDb*, options : WriteOptions*, batch : WriteBatch*, errptr : LibC::Char**)
  fun transaction_merge = rocksdb_transaction_merge(txn : Transaction*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT, errptr : LibC::Char**)
  fun transaction_merge_cf = rocksdb_transaction_merge_cf(txn : Transaction*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT, errptr : LibC::Char**)
  fun transactiondb_merge = rocksdb_transactiondb_merge(txn_db : TransactionDb*, options : WriteOptions*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT, errptr : LibC::Char**)
  fun transactiondb_merge_cf = rocksdb_transactiondb_merge_cf(txn_db : TransactionDb*, options : WriteOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, val : LibC::Char*, vlen : LibC::SizeT, errptr : LibC::Char**)
  fun transaction_delete = rocksdb_transaction_delete(txn : Transaction*, key : LibC::Char*, klen : LibC::SizeT, errptr : LibC::Char**)
  fun transaction_delete_cf = rocksdb_transaction_delete_cf(txn : Transaction*, column_family : ColumnFamilyHandle*, key : LibC::Char*, klen : LibC::SizeT, errptr : LibC::Char**)
  fun transactiondb_delete = rocksdb_transactiondb_delete(txn_db : TransactionDb*, options : WriteOptions*, key : LibC::Char*, klen : LibC::SizeT, errptr : LibC::Char**)
  fun transactiondb_delete_cf = rocksdb_transactiondb_delete_cf(txn_db : TransactionDb*, options : WriteOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, errptr : LibC::Char**)
  fun transaction_create_iterator = rocksdb_transaction_create_iterator(txn : Transaction*, options : ReadOptions*) : Iterator*
  fun transaction_create_iterator_cf = rocksdb_transaction_create_iterator_cf(txn : Transaction*, options : ReadOptions*, column_family : ColumnFamilyHandle*) : Iterator*
  fun transactiondb_create_iterator = rocksdb_transactiondb_create_iterator(txn_db : TransactionDb*, options : ReadOptions*) : Iterator*
  fun transactiondb_create_iterator_cf = rocksdb_transactiondb_create_iterator_cf(txn_db : TransactionDb*, options : ReadOptions*, column_family : ColumnFamilyHandle*) : Iterator*
  fun transactiondb_close = rocksdb_transactiondb_close(txn_db : TransactionDb*)
  fun transactiondb_checkpoint_object_create = rocksdb_transactiondb_checkpoint_object_create(txn_db : TransactionDb*, errptr : LibC::Char**) : Checkpoint*
  fun optimistictransactiondb_open = rocksdb_optimistictransactiondb_open(options : Options*, name : LibC::Char*, errptr : LibC::Char**) : OptimisticTransactionDb*
  fun optimistictransactiondb_open_column_families = rocksdb_optimistictransactiondb_open_column_families(options : Options*, name : LibC::Char*, num_column_families : LibC::Int, column_family_names : LibC::Char**, column_family_options : Options**, column_family_handles : ColumnFamilyHandle**, errptr : LibC::Char**) : OptimisticTransactionDb*
  fun optimistictransactiondb_get_base_db = rocksdb_optimistictransactiondb_get_base_db(otxn_db : OptimisticTransactionDb*) : Db*
  fun optimistictransactiondb_close_base_db = rocksdb_optimistictransactiondb_close_base_db(base_db : Db*)
  fun optimistictransaction_begin = rocksdb_optimistictransaction_begin(otxn_db : OptimisticTransactionDb*, write_options : WriteOptions*, otxn_options : OptimisticTransactionOptions*, old_txn : Transaction*) : Transaction*
  fun optimistictransactiondb_close = rocksdb_optimistictransactiondb_close(otxn_db : OptimisticTransactionDb*)
  fun transactiondb_options_create = rocksdb_transactiondb_options_create : TransactionDbOptions*
  fun transactiondb_options_destroy = rocksdb_transactiondb_options_destroy(opt : TransactionDbOptions*)
  fun transactiondb_options_set_max_num_locks = rocksdb_transactiondb_options_set_max_num_locks(opt : TransactionDbOptions*, max_num_locks : Int64)
  fun transactiondb_options_set_num_stripes = rocksdb_transactiondb_options_set_num_stripes(opt : TransactionDbOptions*, num_stripes : LibC::SizeT)
  fun transactiondb_options_set_transaction_lock_timeout = rocksdb_transactiondb_options_set_transaction_lock_timeout(opt : TransactionDbOptions*, txn_lock_timeout : Int64)
  fun transactiondb_options_set_default_lock_timeout = rocksdb_transactiondb_options_set_default_lock_timeout(opt : TransactionDbOptions*, default_lock_timeout : Int64)
  fun transaction_options_create = rocksdb_transaction_options_create : TransactionOptions*
  fun transaction_options_destroy = rocksdb_transaction_options_destroy(opt : TransactionOptions*)
  fun transaction_options_set_set_snapshot = rocksdb_transaction_options_set_set_snapshot(opt : TransactionOptions*, v : UInt8)
  fun transaction_options_set_deadlock_detect = rocksdb_transaction_options_set_deadlock_detect(opt : TransactionOptions*, v : UInt8)
  fun transaction_options_set_lock_timeout = rocksdb_transaction_options_set_lock_timeout(opt : TransactionOptions*, lock_timeout : Int64)
  fun transaction_options_set_expiration = rocksdb_transaction_options_set_expiration(opt : TransactionOptions*, expiration : Int64)
  fun transaction_options_set_deadlock_detect_depth = rocksdb_transaction_options_set_deadlock_detect_depth(opt : TransactionOptions*, depth : Int64)
  fun transaction_options_set_max_write_batch_size = rocksdb_transaction_options_set_max_write_batch_size(opt : TransactionOptions*, size : LibC::SizeT)
  fun optimistictransaction_options_create = rocksdb_optimistictransaction_options_create : OptimisticTransactionOptions*
  fun optimistictransaction_options_destroy = rocksdb_optimistictransaction_options_destroy(opt : OptimisticTransactionOptions*)
  fun optimistictransaction_options_set_set_snapshot = rocksdb_optimistictransaction_options_set_set_snapshot(opt : OptimisticTransactionOptions*, v : UInt8)
  fun free = rocksdb_free(ptr : Void*)
  fun get_pinned = rocksdb_get_pinned(db : Db*, options : ReadOptions*, key : LibC::Char*, keylen : LibC::SizeT, errptr : LibC::Char**) : PinnableSlice*
  fun get_pinned_cf = rocksdb_get_pinned_cf(db : Db*, options : ReadOptions*, column_family : ColumnFamilyHandle*, key : LibC::Char*, keylen : LibC::SizeT, errptr : LibC::Char**) : PinnableSlice*
  fun pinnableslice_destroy = rocksdb_pinnableslice_destroy(v : PinnableSlice*)
  fun pinnableslice_value = rocksdb_pinnableslice_value(t : PinnableSlice*, vlen : LibC::SizeT*) : LibC::Char*
  fun memory_consumers_create = rocksdb_memory_consumers_create : MemoryConsumers*
  fun memory_consumers_add_db = rocksdb_memory_consumers_add_db(consumers : MemoryConsumers*, db : Db*)
  fun memory_consumers_add_cache = rocksdb_memory_consumers_add_cache(consumers : MemoryConsumers*, cache : Cache*)
  fun memory_consumers_destroy = rocksdb_memory_consumers_destroy(consumers : MemoryConsumers*)
  fun approximate_memory_usage_create = rocksdb_approximate_memory_usage_create(consumers : MemoryConsumers*, errptr : LibC::Char**) : MemoryUsage*
  fun approximate_memory_usage_destroy = rocksdb_approximate_memory_usage_destroy(usage : MemoryUsage*)
  fun approximate_memory_usage_get_mem_table_total = rocksdb_approximate_memory_usage_get_mem_table_total(memory_usage : MemoryUsage*) : UInt64*
  fun approximate_memory_usage_get_mem_table_unflushed = rocksdb_approximate_memory_usage_get_mem_table_unflushed(memory_usage : MemoryUsage*) : UInt64*
  fun approximate_memory_usage_get_mem_table_readers_total = rocksdb_approximate_memory_usage_get_mem_table_readers_total(memory_usage : MemoryUsage*) : UInt64*
  fun approximate_memory_usage_get_cache_total = rocksdb_approximate_memory_usage_get_cache_total(memory_usage : MemoryUsage*) : UInt64*
end
