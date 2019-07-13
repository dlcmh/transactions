module PgsnapRails
  module Sql
    module Commands
      class Base
        class Error < StandardError; end
        extend Utils::MethodCallingConvenience
        include Utils::Echo

        attr_reader :nodes

        def initialize
          @nodes = {}
        end

        def append_tree(*args)
          puts "#{node_name}"
        end

        def build
          raise_need_implementation(__method__)
        end

        def node_name
          raise_need_implementation(__method__)
        end

        private

        def raise_need_implementation(method_name)
          raise Error, "\n=> Implement `#{method_name}` in #{self.class.name}"
        end
      end
    end
  end
end
