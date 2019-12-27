@[Link("rocksdb")]
lib LibRocksDb
  fun free = rocksdb_free(ptr : Void*) : Void

  struct Options
    dummy : UInt8
  end

  fun options_create = rocksdb_options_create : Options*
  fun options_destroy = rocksdb_options_destroy(options : Options*) : Void
  fun options_set_create_if_missing = rocksdb_options_set_create_if_missing(options : Options*, value : UInt8) : Void
  fun options_set_paranoid_checks = rocksdb_options_set_paranoid_checks(options : Options*, value : UInt8) : Void

  struct Db
    dummy : UInt8
  end

  fun open = rocksdb_open(options : Options*, name : UInt8*, errptr : UInt8**) : Db*
  fun close = rocksdb_close(db : Db*) : Void

  struct OptimisticTransactionDb
    dummy : UInt8
  end

  fun optimistictransactiondb_open = rocksdb_optimistictransactiondb_open(options : Options*, name : UInt8*, errptr : UInt8**) : OptimisticTransactionDb*
  fun optimistictransactiondb_close = rocksdb_optimistictransactiondb_close(optimistic_transaction_db : OptimisticTransactionDb*) : Void
  fun optimistictransactiondb_get_base_db = rocksdb_optimistictransactiondb_get_base_db(optimistic_transaction_db : OptimisticTransactionDb*) : Db*
  fun optimistictransactiondb_close_base_db = rocksdb_optimistictransactiondb_close_base_db(db : Db*) : Void

  struct OptimisticTransactionOptions
    dummy : UInt8
  end

  fun optimistictransaction_options_create = rocksdb_optimistictransaction_options_create : OptimisticTransactionOptions*
  fun optimistictransaction_options_destroy = rocksdb_optimistictransaction_options_destroy(optimistic_transaction_options : OptimisticTransactionOptions*) : Void
  fun optimistictransaction_options_set_set_snapshot = rocksdb_optimistictransaction_options_set_set_snapshot(optimistic_transaction_options : OptimisticTransactionOptions*, value : UInt8) : Void

  struct Transaction
    dummy : UInt8
  end

  fun optimistictransaction_begin = rocksdb_optimistictransaction_begin(optimistic_transaction_db : OptimisticTransactionDb*, write_options : WriteOptions*, otxn_options : OptimisticTransactionOptions*, old_txn : Transaction*) : Transaction*
  fun transaction_commit = rocksdb_transaction_commit(txn : Transaction*, errptr : UInt8**)
  fun transaction_rollback = rocksdb_transaction_rollback(txn : Transaction*, errptr : UInt8**)
  fun transaction_set_savepoint = rocksdb_transaction_set_savepoint(txn : Transaction*)
  fun transaction_rollback_to_savepoint = rocksdb_transaction_rollback_to_savepoint(txn : Transaction*, errptr : UInt8**)
  fun transaction_destroy = rocksdb_transaction_destroy(txn : Transaction*)
  fun transaction_get = rocksdb_transaction_get(txn : Transaction*, read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : UInt8**) : UInt8*
  fun transaction_get_for_update = rocksdb_transaction_get_for_update(txn : Transaction*, read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT, vallen : LibC::SizeT*, exclusive : UInt8, errptr : UInt8**) : UInt8*
  fun transaction_put = rocksdb_transaction_put(txn : Transaction*, key : UInt8*, keylen : LibC::SizeT, val : UInt8*, vallen : LibC::SizeT, errptr : UInt8**) : Void

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

  fun get = rocksdb_get(db : Db*, read_options : ReadOptions*, key : UInt8*, keylen : LibC::SizeT, vallen : LibC::SizeT*, errptr : UInt8**) : UInt8*
  fun put = rocksdb_put(db : Db*, write_options : WriteOptions*, key : UInt8*, keylen : LibC::SizeT, val : UInt8*, vallen : LibC::SizeT, errptr : UInt8**) : Void

  struct Iterator
    dummy : UInt8
  end

  fun create_iterator = rocksdb_create_iterator(db : Db*, read_options : ReadOptions*) : Iterator*
  fun iter_destroy = rocksdb_iter_destroy(iter : Iterator*)
  fun iter_valid = rocksdb_iter_valid(iter : Iterator*) : UInt8
  fun iter_seek_to_first = rocksdb_iter_seek_to_first(iter : Iterator*) : Void
  fun iter_seek_to_last = rocksdb_iter_seek_to_last(iter : Iterator*) : Void
  fun iter_seek = rocksdb_iter_seek(iter : Iterator*, key : UInt8*, keylen : LibC::SizeT) : Void
  fun iter_seek_for_prev = rocksdb_iter_seek_for_prev(iter : Iterator*, key : UInt8*, keylen : LibC::SizeT) : Void
  fun iter_next = rocksdb_iter_next(iter : Iterator*) : Void
  fun iter_prev = rocksdb_iter_prev(iter : Iterator*) : Void
  fun iter_key = rocksdb_iter_key(iter : Iterator*, keylen : LibC::SizeT*) : UInt8*
  fun iter_value = rocksdb_iter_value(iter : Iterator*, vallen : LibC::SizeT*) : UInt8*
  fun iter_get_error = rocksdb_iter_get_error(iter : Iterator*, errptr : UInt8**) : Void
end
