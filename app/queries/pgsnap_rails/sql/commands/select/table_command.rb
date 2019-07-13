module PgsnapRails
  module Sql
    module Commands
      module Select
        class TableCommand < Base
          def build(table_name)
            {
              builder_name: builder_name,
              command: 'TABLE',
              args: table_name
            }
          end
        end
      end
    end
  end
end
