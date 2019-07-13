module PgsnapRails
  class Select
    attr_reader :node, :tree

    def initialize
      @tree = {}
    end

    def add_select_list(node)
      @node = node
      node_type = 'SelectList'
      validate(node_type)
      @tree[node_type.to_sym] = node
    end

    def to_s
      tree
    end

    private

    def validate(node_type)
      return if node.class.name.demodulize == node_type
      raise ArgumentError, "#{node} not a valid #{node_type} object"
    end
  end
end
