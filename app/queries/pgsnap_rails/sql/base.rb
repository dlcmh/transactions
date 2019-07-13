module PgsnapRails
  module Sql
    class Base
      class Error < StandardError; end
      include Utils::Echo
      include Utils::NodeName

      def self.method_missing(method, *args, &block)
        new.tap do |obj|
          obj.send(method, *args, &block)
        end.nodes
      end

      attr_reader :nodes

      def build
        raise_need_implementation(__method__)
      end

      private

      def initialize
        @nodes = {}
      end

      def append_tree(hsh)
        return node[:args] << hsh[:args] if node
        create_node(hsh)
      end

      def create_node(hsh)
        nodes[node_name] = {
          command: hsh[:command],
          args: Array(hsh[:args])
        }
      end

      def node
        nodes[node_name]
      end

      def raise_need_implementation(method_name)
        raise Error, "\n=> Implement `#{method_name}` in #{self.class.name}"
      end
    end
  end
end
