module PgsnapRails
  module Keywords
    def all
      select_builder.all
    end

    def columns
      select_builder.columns
    end

    def limit(count)
      select_builder.add_to_tree Limit.new(count)
      self
    end

    def select(*items)
      select_builder.add_to_tree SelectList.new.with(*items)
      self
    end

    def table(table_name = self.class.name.demodulize.underscore)
      select_builder.add_to_tree Table.new(table_name)
      self
    end
  end
end
