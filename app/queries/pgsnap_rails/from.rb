module PgsnapRails
  class From
    attr_reader :args, :item

    def initialize(*args)
      @args = args
      validate
    end

    def to_s
      ['FROM', source].compact.join(' ')
    end

    private

    def item__params
      @item, = args
    end

    def source
      subquery = item.new.try(:sql)
      return %[(#{subquery}) "#{item.name.demodulize.underscore}"] if subquery
      item
    end

    def validate
      if args.size == 1
        item__params
      else
        raise ArgumentError, 'Expected (1) item'
      end
    end
  end
end
