module PgsnapRails
  module Sql
    module Commands
      class Base
        class Error < StandardError; end
        include Utils::Echo
        include Utils::NodeName

        def self.method_missing(method, *args, &block)
          new.send(method, *args, &block)
        end

        attr_reader :nodes

        def build
          raise_need_implementation(__method__)
        end

        private

        def initialize
          @nodes = {}
        end

        def append_tree(*args)
          nodes[node_name] ? nodes[node_name] << args : nodes[node_name] = args
          self
        end

        def raise_need_implementation(method_name)
          raise Error, "\n=> Implement `#{method_name}` in #{self.class.name}"
        end
      end
    end
  end
end
