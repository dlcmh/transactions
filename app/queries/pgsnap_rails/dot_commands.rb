module PgsnapRails
  module DotCommands
    def table
      Sql::Commands::Select::TableCommand.build(table_name)
      self
    end
  end
end
