module PgsnapRails
  module Pg
    class Results < Base
      attr_reader :results

      def retrieve
        @results = Exec.query('select * from users', 'Users').to_a
      end
    end
  end
end
