module PgsnapRails
  module DotCommands
    def table
      @nodes = Sql::Commands::Select::TableCommand.build(table_name)
    end
  end
end
