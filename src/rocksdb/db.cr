require "../librocksdb"
require "./snapshot"
require "./base"

module RocksDB
  class ClosedDatabaseError < Error
  end

  struct ColumnFamilyHandle
    def initialize(@value : Pointer(LibRocksDB::ColumnFamilyHandle))
    end

    def to_unsafe
      @value
    end
  end

  class Database
    def initialize(@value : LibRocksDB::Db*, @families = {} of String => ColumnFamilyHandle)
      @default_read_options = ReadOptions.new
      @default_write_options = WriteOptions.new
    end

    def to_unsafe
      @value
    end

    def finalize
      close
    end

    def closed?
      @value.null?
    end

    def close
      return if closed?
      @families.values.each do |cf|
        LibRocksDB.column_family_handle_destroy(cf)
      end
      LibRocksDB.close(@value)
      @value = Pointer(LibRocksDB::Db).null
    end

    def self.open(path : String, options : Options)
      new(RocksDB.err_check do |err|
        LibRocksDB.open(options, path, err)
      end)
    end

    def self.open(path : String, options : Options, families : Hash(String, Options))
      names = families.keys
      family_names = names.map(&.to_unsafe).to_unsafe
      family_options = names.map { |name| families[name].to_unsafe }.to_unsafe
      handles = Pointer(LibRocksDB::ColumnFamilyHandle*).malloc(names.size)
      db = RocksDB.err_check do |err|
        LibRocksDB.open_column_families(options, path, families.size, family_names, family_options, handles, err)
      end
      handle_table = names.map_with_index { |name, i| {name, ColumnFamilyHandle.new(handles[i])} }.to_h
      new(db, handle_table)
    end

    def self.list_column_families(path : String, options : Options)
      len = uninitialized LibC::SizeT
      list = RocksDB.err_check do |err|
        LibRocksDB.list_column_families(options, path, pointerof(len), err)
      end
      strings = (0...len).map { |i| String.new(list[i]) }
      LibRocksDB.list_column_families_destroy(list, len)
      strings
    end

    def family_handle(name : String)
      @families[name]
    end

    def family_handle?(name : String)
      @families[name]?
    end

    def create_column_family(name : String, options : Options)
      @families[name] = ColumnFamilyHandle.new(RocksDB.err_check do |err|
        LibRocksDB.create_column_family(self, options, name, err)
      end)
    end

    def drop_column_family(name : String) : Nil
      handle = @families[name]
      RocksDB.err_check do |err|
        LibRocksDB.drop_column_family(self, handle, err)
      end
      @families.delete(name)
    end

    def get(key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      raise ClosedDatabaseError.new if closed?
      len = uninitialized LibC::SizeT
      ptr = RocksDB.err_check do |err|
        LibRocksDB.get(self, read_options, key, key.size, pointerof(len), err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def get(column_family : ColumnFamilyHandle, key : Bytes, read_options : ReadOptions = @default_read_options) : Bytes?
      raise ClosedDatabaseError.new if closed?
      len = uninitialized LibC::SizeT
      ptr = RocksDB.err_check do |err|
        LibRocksDB.get_cf(self, read_options, column_family, key, key.size, pointerof(len), err)
      end
      ptr.null? ? nil : Bytes.new(ptr, len)
    end

    def put(key : Bytes, value : Bytes, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.put(self, write_options, key, key.size, value, value.size, err)
      end
    end

    def put(column_family : ColumnFamilyHandle, key : Bytes, value : Bytes, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.put_cf(self, write_options, column_family, key, key.size, value, value.size, err)
      end
    end

    def delete(key : Bytes, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.delete(self, write_options, key, key.size, err)
      end
    end

    def delete(column_family : ColumnFamilyHandle, key : Bytes, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.delete_cf(self, write_options, column_family, key, key.size, err)
      end
    end

    def write(batch : WriteBatch, write_options : WriteOptions = @default_write_options) : Nil
      raise ClosedDatabaseError.new if closed?
      RocksDB.err_check do |err|
        LibRocksDB.write(self, write_options, batch, err)
      end
    end

    def iterator(read_options : ReadOptions = @default_read_options)
      raise ClosedDatabaseError.new if closed?
      Iterator.new(LibRocksDB.create_iterator(self, read_options), self)
    end

    def snapshot
      raise ClosedDatabaseError.new if closed?
      Snapshot.new(LibRocksDB.create_snapshot(self), self)
    end

    class Snapshot < BaseSnapshot
      def initialize(snapshot : LibRocksDB::Snapshot*, @db : Database)
        super(snapshot)
      end

      def finalize
        LibRocksDB.release_snapshot(@db, self) unless @db.to_unsafe.null?
      end
    end
  end
end
