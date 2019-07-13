module PgsnapRails
  module Sql
    module Commands
      module Select
        class TableCommand < Base
          def build(*args)
            echo args
          end
        end
      end
    end
  end
end
