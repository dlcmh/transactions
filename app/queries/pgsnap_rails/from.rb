module PgsnapRails
  class From
    attr_reader :args,
                :output_name, :item

    def initialize(*args)
      @args = args
      validate
    end

    def to_s
      ['FROM', item].compact.join(' ')
    end

    private

    def item__params
      @item, = args
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
