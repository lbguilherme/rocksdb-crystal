require "spec"
require "file_utils"
require "../src/rocksdb"

describe RocksDb do
  it "works with a simple database" do
    path = "tmp_#{Random::Secure.hex}"
    options = RocksDb::Options.new
    options.create_if_missing = true
    db = RocksDb::Database.open(path, options)
    db.get(Bytes[1, 2, 0, 3]).should eq nil
    db.put(Bytes[1, 2, 0, 3], Bytes[0, 1, 0])
    db.get(Bytes[1, 2, 0, 3]).should eq Bytes[0, 1, 0]
    db.close
    FileUtils.rm_rf path
  end
end
