module PgsnapRails
  class Base
    class Error < StandardError; end
    include DotCommands
    include Utils::TableName

    # returns self
    def self.method_missing(method, *args, &block)
      new.tap do |obj|
        obj.send(method, *args, &block)
      end
    end

    attr_reader :nodes

    def from(from_item)
      @nodes = Sql::Commands::Select::FromClause.build(from_item)
    end

    # def inspect
    #   'lol'
    # end
  end
end
