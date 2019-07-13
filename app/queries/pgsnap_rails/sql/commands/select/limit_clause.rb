module PgsnapRails
  module Sql
    module Commands
      module Select
        class LimitClause < Base
          def build(count)
            {
              builder_name: builder_name,
              command: 'LIMIT',
              args: count
            }
          end
        end
      end
    end
  end
end
