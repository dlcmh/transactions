module PgsnapRails
  class SelectItem
    attr_reader :args,
                :output_name, :expression

    def initialize(*args)
      @args = args
      validate
    end

    def to_s
      [expression, output_name__formatted].compact.join(' ')
    end

    private

    def expression__params
      @expression, = args
    end

    def output_name__expression__params
      @output_name, @expression = args
    end

    def output_name__formatted
      %(AS "#{output_name}") if output_name
    end

    def validate
      if args.size == 1
        expression__params
      elsif args.size == 2
        output_name__expression__params
      else
        raise ArgumentError, 'Expected (1) column expression, or (2) alias, column expression'
      end
    end
  end
end
