require "spec"
require "file_utils"
require "../src/rocksdb"

describe RocksDB do
  it "works with a simple database" do
    path = "tmp_#{Random::Secure.hex}"
    options = RocksDB::Options.new
    options.create_if_missing = true
    db = RocksDB::Database.open(path, options)
    db.get(Bytes[1, 2, 0, 3]).should eq nil
    db.put(Bytes[1, 2, 0, 3], Bytes[0, 1, 0])
    db.get(Bytes[1, 2, 0, 3]).should eq Bytes[0, 1, 0]
    db.delete(Bytes[1, 2, 0, 3])
    db.get(Bytes[1, 2, 0, 3]).should eq nil
    db.close
    FileUtils.rm_rf path
  end

  it "writes with batch" do
    path = "tmp_#{Random::Secure.hex}"
    options = RocksDB::Options.new
    options.create_if_missing = true
    db = RocksDB::Database.open(path, options)
    db.get(Bytes[1, 2, 0, 3]).should eq nil
    batch = RocksDB::WriteBatch.new
    batch.put(Bytes[1, 2, 0, 3], Bytes[0, 1, 0])
    batch.put(Bytes[2], Bytes[2])
    batch.put(Bytes[3], Bytes[3])
    batch.delete(Bytes[2])
    batch.count.should eq 4
    db.get(Bytes[1, 2, 0, 3]).should eq nil
    db.write(batch)
    db.get(Bytes[1, 2, 0, 3]).should eq Bytes[0, 1, 0]
    db.get(Bytes[2]).should eq nil
    db.get(Bytes[3]).should eq Bytes[3]
    db.close
    FileUtils.rm_rf path
  end

  it "accepts db options" do
    path = "tmp_#{Random::Secure.hex}"
    options = RocksDB::Options.new
    options.create_if_missing = true
    options.paranoid_checks = false
    options.enable_pipelined_write = true
    options.allow_ingest_behind = true
    options.increase_parallelism(16)
    options.max_background_jobs = 4
    db = RocksDB::Database.open(path, options)
    db.close
    FileUtils.rm_rf path
  end
end
