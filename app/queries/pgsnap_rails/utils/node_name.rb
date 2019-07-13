module PgsnapRails
  module Utils
    module NodeName
      include ClassName

      private

      def node_name
        class_name.demodulize.underscore.to_sym
      end
    end
  end
end
