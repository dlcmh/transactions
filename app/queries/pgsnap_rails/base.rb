module PgsnapRails
  class Base
    class Error < StandardError; end
    include SqlBuildingDotCommands

    def self.method_missing(method, *args, &block)
      new.send(method, *args, &block)
    end

    attr_reader :builder_name, :built_sql, :nodes, :results, :sql_builder

    def all
      @results = Pg::Results.retrieve(built_sql, self.class.name.demodulize.underscore)
      self
    end

    private

    def initialize
      @nodes = {}
      @sql_builder = Builder
    end

    def append_node(hsh)
      @builder_name = hsh[:builder_name]
      return node[:args] << hsh[:args] if node
      create_node(hsh)
    end

    def build_sql
      @built_sql = sql_builder.build(nodes)
      self
    end

    def create_node(hsh)
      nodes[builder_name] = {
        command: hsh[:command],
        args: Array(hsh[:args])
      }
    end

    def node
      nodes[builder_name]
    end

    # def inspect
    #   'lol'
    # end
  end
end
