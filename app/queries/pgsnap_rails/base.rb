module PgsnapRails
  class Base
    class Error < StandardError; end
    include Utils::DelegateArrayMethods
    include RetrievalDotCommands
    include SqlBuildingDotCommands

    def self.method_missing(method, *args, &block)
      new.send(method, *args, &block)
    end

    attr_reader :builder_name, :built_sql, :nodes, :results, :retrieval_done

    def sql
      built_sql
    end

    private

    def initialize
      @nodes = {}
      defn
    end

    def append_node(hsh)
      @builder_name = hsh[:builder_name]
      node ? node[:args] << hsh[:args] : create_node(hsh)
      build_sql
    end

    def defn; end

    def build_sql
      @built_sql = Builder.build(nodes)
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

    def remove_node(builder_name)
      nodes.delete(builder_name)
      build_sql
    end

    def retrieve_results_from_database
      return if retrieval_done
      build_missing_from_clause
      build_missing_select_command
      @results = Pg::Results.retrieve(built_sql, self.class.name.demodulize.underscore)
    end
  end
end
