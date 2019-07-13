module PgsnapRails
  module Pg
    class Results < Base
      attr_reader :rows

      def retrieve(sql, class_name)
        @rows = Exec.query(sql, class_name).to_a
        self
      end
    end
  end
end
