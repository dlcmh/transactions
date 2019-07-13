module PgsnapRails
  class Builder < Base
    attr_reader :built_sql, :nodes

    def build(nodes)
      @nodes = nodes
      select_command__build
      from_clause__build
      table_command__build
      limit_clause__build
      built_sql
    end

    private

    def append_to_built_sql(str)
      @built_sql = [built_sql, str].join(' ')
    end

    def from_clause__build
      return unless nodes[:from_clause]
      append_to_built_sql str(:from_clause)
    end

    def limit_clause__build
      return unless nodes[:limit_clause]
      append_to_built_sql str(:limit_clause)
    end

    def select_command__build
      return unless nodes[:select_command]
      overwrite_built_sql str(:select_command, true)
    end

    def table_command__build
      return unless nodes[:table_command]
      overwrite_built_sql str(:table_command)
    end

    def str(node_type, use_all_args = false)
      arg_str = use_all_args ? nodes[node_type][:args].join(', ') : nodes[node_type][:args].last
      [
        nodes[node_type][:command],
        arg_str
      ].join(' ')
    end

    def overwrite_built_sql(str)
      @built_sql = str
    end
  end
end
