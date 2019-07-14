module PgsnapRails
  class From
    attr_reader :args, :item, :source, :table

    def initialize(*args)
      @args = args
      validate
      detect_table_type
    end

    def to_s
      ['FROM', source].compact.join(' ')
    end

    private

    def detect_table_type
      if item.try(:new).try(:sql) # Pgsnap subclass
        subquery = item.new.sql
        name = item.name.demodulize.underscore
        @table = {
          name: name,
          type: :pgsnap_subquery
        }
        @source = %[(#{subquery}) "#{name}"]
        return
      elsif item.try(:all).try(:to_sql) # ActiveRecord subclass
        subquery = item.all.to_sql
        name = item.name.demodulize.underscore.pluralize
        @table = {
          name: name,
          type: :active_record_subquery
        }
        @source = %[(#{subquery}) "#{name}"]
        return
      end
      @table = {
        name: item,
        type: :pg
      }
      @source = item
    end

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
