module PgsnapRails
  module Utils
    module MethodCallingConvenience
      def method_missing(method, *args, &block)
        new.send(method, *args, &block)
      end
    end
  end
end
