module PgsnapRails
  module Sql
    module Commands
      module Select
        class FromClause < Base
          def build(from_item)
            {
              builder_name: builder_name,
              command: 'FROM',
              args: from_item
            }
          end
        end
      end
    end
  end
end
