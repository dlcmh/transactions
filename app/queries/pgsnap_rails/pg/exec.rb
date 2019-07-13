module PgsnapRails
  module Pg
    class Exec < Base
      def query(sql, class_name)
        ActiveRecord::Base.connection.select_all(sql, class_name)
      end
    end
  end
end
