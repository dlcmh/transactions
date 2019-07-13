module PgsnapRails
  module Sql
    module Commands
      module Select
        class TableCommand < Base
          def build(table_name)
            append_tree(command: 'TABLE', args: table_name)
          end
        end
      end
    end
  end
end
