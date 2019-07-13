module PgsnapRails
  module Pg
    class Base
      def self.method_missing(method, *args, &block)
        new.send(method, *args, &block)
      end
    end
  end
end
