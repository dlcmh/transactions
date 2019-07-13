module PgsnapRails
  module Sql
    module Commands
      module Select
        class TableCommand < Base
          def build(table_name)
            append_tree(table_name)
          end
        end
      end
    end
  end
end
