module PgsnapRails
  module Keywords
    def from(item)
      add_to_tree From.new(item)
      self
    end

    def limit(count)
      add_to_tree Limit.new(count)
      self
    end

    def select(*items)
      add_to_tree SelectList.new.with(*items)
      self
    end

    def table(table_name = self.class.name.demodulize.underscore)
      add_to_tree Table.new(table_name)
      self
    end
  end
end
