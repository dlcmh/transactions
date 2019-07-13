module PgsnapRails
  class Limit
    attr_reader :args, :count

    def initialize(*args)
      @args = args
      validate
    end

    def to_s
      ['LIMIT', count].compact.join(' ')
    end

    private

    def count__params
      @count, = args
    end

    def validate
      if args.size == 1
        count__params
      else
        raise ArgumentError, 'Expected (1) count'
      end
    end
  end
end
