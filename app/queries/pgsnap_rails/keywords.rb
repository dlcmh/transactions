module PgsnapRails
  module Keywords
    def all
      select_builder.all
    end

    def limit(count)
      select_builder.add_limit PgsnapRails::Limit.new(count)
      self
    end

    def table(table_name = self.class.name.demodulize.underscore)
      select_builder.add_table PgsnapRails::Table.new(:categories)
      self
    end
  end
end
