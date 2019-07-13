module PgsnapRails
  module DotCommands
    def from(from_item)
      @nodes = Sql::Commands::Select::FromClause.build(from_item)
    end

    def table
      @nodes = Sql::Commands::Select::TableCommand.build(table_name)
    end
  end
end
