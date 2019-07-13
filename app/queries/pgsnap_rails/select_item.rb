module PgsnapRails
  class SelectItem
    attr_reader :args,
                :output_name, :expression

    def initialize(*args)
      @args = args
      if args.size == 1
        expression__params
      elsif args.size == 2
        output_name__expression__params
      else
        raise ArgumentError, 'Expected (1) column expression, or (2) alias, column expression'
      end
      @output_name = output_name
      @expression = expression
    end

    def to_s
      [expression, output_name__formatted].compact.join(' ')
    end

    private

    def output_name__formatted
      %(AS "#{output_name}") if output_name
    end

    def expression__params
      @expression, = args
    end

    def output_name__expression__params
      @output_name, @expression = args
    end
  end
end
