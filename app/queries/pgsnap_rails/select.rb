module PgsnapRails
  class Select
    attr_reader :built_sql, :node, :node_type, :results, :retrieval_done, :tree

    def initialize
      @tree = {}
    end

    def add_from(node)
      add_node_to_tree(:From, node)
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

    def all
      retrieve_results_from_database
      @retrieval_done = true
      results.to_a
    end

    def to_s
      tree
    end

    private

    def build_sql
      select_list__build
      # from_clause__build
      # table_command__build
      # limit_clause__build
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

    def select_list__build
      return unless tree_has_node_type?
      @built_sql = [built_sql, stringified_tree_node].compact.join(' ')
    end

    def stringified_tree_node
      tree[node_type].to_s
    end

    def tree_has_node_type?
      tree[node_type].present?
    end

    def validate_node_type
      return if node.class.name.demodulize == node_type.to_s
      raise ArgumentError, "#{node} is not a valid #{node_type} object"
    end
  end
end
