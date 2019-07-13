module PgsnapRails
  module Utils
    module MethodCallingConvenience
      def method_missing(method, *args, &block)
        new.tap do |obj|
          obj.send(method, *args, &block)
          obj.try(:return_self)
        end
      end
    end
  end
end
