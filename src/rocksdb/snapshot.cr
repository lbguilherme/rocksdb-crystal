lib LibRocksDB
  struct Snapshot
    dummy : UInt8
  end
end

module RocksDB
  abstract class BaseSnapshot
    @value : LibRocksDB::Snapshot*

    def to_unsafe
      @value
    end

    def initialize(@value : LibRocksDB::Snapshot*)
    end
  end
end
