module PgsnapRails
  class Table
    attr_reader :args,
                :table_name

    def initialize(*args)
      @args = args
      validate
    end

    def to_s
      [:TABLE, table_name].compact.join(' ')
    end

    private

    def table_name__params
      @table_name, = args
    end

    def validate
      if args.size == 1
        table_name__params
      else
        raise ArgumentError, 'Expected table name'
      end
    end
  end
end
