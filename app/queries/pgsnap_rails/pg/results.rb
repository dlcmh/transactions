module PgsnapRails
  module Pg
    class Results < Base
      def retrieve(sql, class_name)
        ActiveRecord::Base.connection.select_all(sql, class_name)
      end
    end
  end
end
