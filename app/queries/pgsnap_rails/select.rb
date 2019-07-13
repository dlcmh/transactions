module PgsnapRails
  class Select
    attr_reader :built_sql, :node, :node_type, :results, :retrieval_done, :tree

    def initialize
      @tree = {}
    end

    def add_from(node)
      add_node_to_tree(:From, node)
    end

    def add_limit(node)
      add_node_to_tree(:Limit, node)
    end

    def add_node_to_tree(node_type, node)
      @node = node
      @node_type = node_type
      validate_node_type
      @tree[node_type] = node
      build_sql
    end

    def add_select_list(node)
      add_node_to_tree(:SelectList, node)
    end

    def add_table(node)
      add_node_to_tree(:Table, node)
    end

    def all
      retrieve_results_from_database
      @retrieval_done = true
      results.to_a
    end

    def columns
      current_limit = tree[:Limit]&.count
      add_limit(Limit.new(0))
      retrieve_results_from_database
      r = results.columns
      if current_limit
        add_limit(Limit.new(current_limit))
      else
        remove_node_from_tree(:Limit)
      end
      r
    end

    def remove_node_from_tree(node_type)
      tree.delete(node_type)
    end

    def to_s
      tree
    end

    private

    def build_sql
      if tree[:Table]
        @built_sql = [
          tree[:Table],
          tree[:Limit],
        ].compact.join(' ')
      else
        @built_sql = [
          tree[:SelectList],
          tree[:From],
          tree[:Limit],
        ].compact.join(' ')
      end
    end

    def results_retrieval_class_name
      self.class.name.demodulize.underscore
    end

    def retrieve_results_from_database
      return if retrieval_done
      # build_missing_from_clause
      # build_missing_select_list
      @results = Pg::Results.retrieve(built_sql, results_retrieval_class_name)
    end

    def validate_node_type
      return if node.class.name.demodulize == node_type.to_s
      raise ArgumentError, "#{node} is not a valid #{node_type} object"
    end
  end
end
