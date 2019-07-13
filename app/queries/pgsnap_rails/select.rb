module PgsnapRails
  class Select
    attr_reader :built_sql, :node, :results, :retrieval_done, :tree

    def initialize
      @tree = {}
    end

    def add_select_list(node)
      @node = node
      node_type = 'SelectList'
      validate(node_type)
      @tree[node_type.to_sym] = node
    end

    def all
      @built_sql = 'select 1'
      retrieve_results_from_database
      @retrieval_done = true
      results.to_a
    end

    def to_s
      tree
    end

    private

    def results_retrieval_class_name
      self.class.name.demodulize.underscore
    end

    def retrieve_results_from_database
      return if retrieval_done
      # build_missing_from_clause
      # build_missing_select_command
      @results = Pg::Results.retrieve(built_sql, results_retrieval_class_name)
    end

    def validate(node_type)
      return if node.class.name.demodulize == node_type
      raise ArgumentError, "#{node} not a valid #{node_type} object"
    end
  end
end
