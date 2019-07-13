module PgsnapRails
  module SqlBuildingDotCommands
    def from(from_item)
      overwrite_node Sql::Commands::Select::FromClause.build(from_item)
      build_sql
    end

    def limit(count)
      overwrite_node Sql::Commands::Select::LimitClause.build(count)
      build_sql
    end

    def table
      append_node Sql::Commands::Select::TableCommand.build(self.class.name.demodulize.underscore)
      build_sql
    end
  end
end
