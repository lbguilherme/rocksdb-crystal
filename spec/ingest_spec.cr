require "spec"
require "file_utils"
require "../src/rocksdb"

describe RocksDB do
  it "can ingest an sst_file" do
    path = "tmp_#{Random::Secure.hex}"
    options = RocksDB::Options.new
    options.create_if_missing = true
    db = RocksDB::Database.open(path, options)
    db.get(Bytes[1]).should eq nil
    db.put(Bytes[1], Bytes[11])
    db.put(Bytes[2], Bytes[22])
    db.put(Bytes[3], Bytes[33])
    db.delete(Bytes[4])
    db.get(Bytes[1]).should eq Bytes[11]
    db.get(Bytes[2]).should eq Bytes[22]
    db.get(Bytes[3]).should eq Bytes[33]
    db.get(Bytes[4]).should eq nil

    sst_file_path = "tmp_#{Random::Secure.hex}"
    sst_file_writer = RocksDB::SstFileWriter.new(RocksDB::EnvOptions.new, RocksDB::Options.new)
    sst_file_writer.open(sst_file_path)
    sst_file_writer.put(Bytes[2], Bytes[55])
    sst_file_writer.delete(Bytes[3])
    sst_file_writer.put(Bytes[4], Bytes[66])
    sst_file_writer.finish
    sst_file_writer.file_size.should be > 0

    ingest_options = RocksDB::IngestExternalFileOptions.new
    db.ingest_external_file([sst_file_path], ingest_options)
    db.get(Bytes[1]).should eq Bytes[11]
    db.get(Bytes[2]).should eq Bytes[55]
    db.get(Bytes[3]).should eq nil
    db.get(Bytes[4]).should eq Bytes[66]

    db.close
    FileUtils.rm_rf sst_file_path
    FileUtils.rm_rf path
  end

  it "can ingest an sst_file into the past" do
    path = "tmp_#{Random::Secure.hex}"
    options = RocksDB::Options.new
    options.create_if_missing = true
    options.allow_ingest_behind = true
    db = RocksDB::Database.open(path, options)
    db.get(Bytes[1]).should eq nil
    db.put(Bytes[1], Bytes[11])
    db.put(Bytes[2], Bytes[22])
    db.put(Bytes[3], Bytes[33])
    db.delete(Bytes[2])
    db.get(Bytes[1]).should eq Bytes[11]
    db.get(Bytes[2]).should eq nil
    db.get(Bytes[3]).should eq Bytes[33]
    db.get(Bytes[4]).should eq nil

    sst_file_path = "tmp_#{Random::Secure.hex}"
    sst_file_writer = RocksDB::SstFileWriter.new(RocksDB::EnvOptions.new, RocksDB::Options.new)
    sst_file_writer.open(sst_file_path)
    sst_file_writer.put(Bytes[2], Bytes[55])
    sst_file_writer.delete(Bytes[3])
    sst_file_writer.put(Bytes[4], Bytes[66])
    sst_file_writer.finish
    sst_file_writer.file_size.should be > 0

    ingest_options = RocksDB::IngestExternalFileOptions.new
    ingest_options.ingest_behind = true
    db.ingest_external_file([sst_file_path], ingest_options)
    db.get(Bytes[1]).should eq Bytes[11]
    db.get(Bytes[2]).should eq nil
    db.get(Bytes[3]).should eq Bytes[33]
    db.get(Bytes[4]).should eq Bytes[66]

    db.close
    FileUtils.rm_rf sst_file_path
    FileUtils.rm_rf path
  end
end
