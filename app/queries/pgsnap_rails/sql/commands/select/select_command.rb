module PgsnapRails
  module Sql
    module Commands
      module Select
        class SelectCommand < Base
          def build(select_list_items)
            {
              builder_name: builder_name,
              command: 'SELECT',
              args: select_list_items
            }
          end
        end
      end
    end
  end
end
