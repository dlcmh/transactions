module PgsnapRails
  module Utils
    module TableName
      include ClassName

      private

      def table_name
        class_name.demodulize.underscore
      end
    end
  end
end
