module PgsnapRails
  class Base
    class Error < StandardError; end
    include Utils::DelegateArrayMethods
    include Keywords

    def self.method_missing(method, *args, &block)
      new.send(method, *args, &block)
    end

    attr_reader :builder_name, :built_sql, :nodes, :results, :retrieval_done, :select_builder

    delegate :add_to_tree, :all, :built_sql, :columns, to: :select_builder

    def defn
      self.table
    end

    def sql
      built_sql
    end

    private

    def initialize
      @select_builder = Select.new(query_class: self.class.name.demodulize.underscore)
      @nodes = {}
      defn
    end

    def append_node(hsh)
      @builder_name = hsh[:builder_name]
      node ? node[:args] << hsh[:args] : create_node(hsh)
      build_sql
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

    def overwrite_node(hsh)
      @builder_name = hsh[:builder_name]
      node ? node[:args] = Array(hsh[:args]) : create_node(hsh)
      build_sql
    end
  end
end
