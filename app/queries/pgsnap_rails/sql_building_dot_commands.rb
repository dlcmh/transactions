module PgsnapRails
  module SqlBuildingDotCommands
    def build_missing_select
      return if nodes[:select_command]
      overwrite_node Sql::Commands::Select::SelectCommand.build(:*)
      self
    end

    def from(from_item)
      overwrite_node Sql::Commands::Select::FromClause.build(from_item)
      self
    end

    def limit(count)
      overwrite_node Sql::Commands::Select::LimitClause.build(count)
      self
    end

    def select(*select_list_items)
      append_node Sql::Commands::Select::SelectCommand.build(select_list_items)
      self
    end

    def table
      append_node Sql::Commands::Select::TableCommand.build(self.class.name.demodulize.underscore)
      self
    end
  end
end
