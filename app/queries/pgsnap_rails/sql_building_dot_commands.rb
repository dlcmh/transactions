module PgsnapRails
  module SqlBuildingDotCommands
    def from(from_item)
      append_node Sql::Commands::Select::FromClause.build(from_item)
      self
    end

    def table
      append_node Sql::Commands::Select::TableCommand.build(self.class.name.demodulize.underscore)
      self
    end
  end
end
