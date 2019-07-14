module PgsnapRails
  class Select
    include ArrayMethodsForDelegation

    attr_reader :built_sql, :node, :node_type, :query_class, :results, :retrieval_done, :tree

    # to handle calles from eg a view -> @some_instance_variable.each ...
    # https://github.com/nanoc/nanoc/issues/244#issuecomment-14071615
    # https://github.com/bobthecow/nanoc/blob/67ad983d3ea397862080b5a420a1fa07583ae97e/lib/nanoc/base/source_data/item_array.rb#L12
    delegate *ARRAY_METHODS_FOR_DELEGATION, to: :all

    def initialize(query_class: self.class.name.demodulize.underscore)
      @query_class = query_class
      @tree = {}
    end

    def add_to_tree(node)
      # p "debug: #{node}"
      @node = node
      @node_type = node.class.name.demodulize.to_sym
      validate_node_type
      @tree[node_type] = node
      build_sql
    end

    def all
      retrieve_results_from_database
      @retrieval_done = true
      results.to_a
    end

    def columns
      current_limit = tree[:Limit]&.count
      add_to_tree(Limit.new(0))
      retrieve_results_from_database
      results.columns.tap do
        current_limit ? add_to_tree(Limit.new(current_limit)) : remove_node_from_tree(:Limit)
      end
    end

    def inspect
      tree
    end

    def remove_node_from_tree(node_type)
      tree.delete(node_type)
    end

    def to_s
      tree
    end

    private

    def build_missing_from_clause
      add_to_tree(From.new(query_class)) unless tree[:From]
    end

    def build_missing_select_list
      select_list = SelectList.new
      select_item = SelectItem.new(:*)
      select_list.add(select_item)
      add_to_tree(select_list) unless tree[:SelectList]
    end

    def build_sql
      tree[:Table] ? generate_table_sql : generate_normal_sql
    end

    def generate_normal_sql
      @built_sql = [
        tree[:SelectList],
        tree[:From],
        tree[:Limit],
      ].compact.join(' ')
    end

    def generate_table_sql
      @built_sql = [
        tree[:Table],
        tree[:Limit]
      ].compact.join(' ')
    end

    def results_retrieval_class_name
      self.class.name.demodulize.underscore
    end

    def retrieve_results_from_database
      return if retrieval_done
      build_missing_from_clause
      build_missing_select_list
      @results = Pg::Results.retrieve(built_sql, results_retrieval_class_name)
    end

    def validate_node_type
      return if node.class.name.demodulize == node_type.to_s
      raise ArgumentError, "#{node} is not a valid #{node_type} object"
    end
  end
end
