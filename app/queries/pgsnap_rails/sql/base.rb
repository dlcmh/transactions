module PgsnapRails
  module Sql
    class Base
      class Error < StandardError; end
      include Utils::Echo

      def self.method_missing(method, *args, &block)
        new.send(method, *args, &block)
      end

      def build
        raise_need_implementation(__method__)
      end

      def raise_need_implementation(method_name)
        raise Error, "\n=> Implement `#{method_name}` in #{self.class.name}"
      end

      private

      def builder_name
        self.class.name.demodulize.underscore.to_sym
      end
    end
  end
end
