require "spec"
require "file_utils"
require "../src/rocksdb"

describe RocksDB do
  {% for dbClass in [RocksDB::Database, RocksDB::OptimisticTransactionDatabase, RocksDB::TransactionDatabase] %}
    it "lists column families on a base database" do
      path = "tmp_#{Random::Secure.hex}"
      options = RocksDB::Options.new
      options.create_if_missing = true
      db = {{ dbClass }}.open(path, options)
      db.close
      families = RocksDB::Database.list_column_families(path, options)
      families.should eq ["default"]
      FileUtils.rm_rf path
    end

    it "opens with column families" do
      path = "tmp_#{Random::Secure.hex}"
      options = RocksDB::Options.new
      options.create_if_missing = true

      db = {{ dbClass }}.open(path, options)
      db.close

      db = {{ dbClass }}.open(path, options, {"default" => options})
      handle = db.family_handle("default")

      db.put(Bytes[1], Bytes[10])
      db.put(handle, Bytes[2], Bytes[20])

      db.get(handle, Bytes[1]).should eq Bytes[10]
      db.get(Bytes[2]).should eq Bytes[20]

      handle2 = db.create_column_family("test", options)
      db.get(handle2, Bytes[2]).should eq nil
      db.put(handle2, Bytes[2], Bytes[2000])
      db.get(handle2, Bytes[2]).should eq Bytes[2000]
      db.get(handle, Bytes[2]).should eq Bytes[20]
      db.get(Bytes[2]).should eq Bytes[20]
      db.close

      families = RocksDB::Database.list_column_families(path, options)
      families.should eq ["default", "test"]

      FileUtils.rm_rf path
    end
  {% end %}
end
