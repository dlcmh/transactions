module PgsnapRails
  class SelectList
    attr_reader :item, :items

    def initialize
      @items = []
    end

    def add(item)
      @item = item
      validate
      @items << item
    end

    def to_s
      return unless items.present?
      [:SELECT, items.join(', ')].join(' ')
    end

    private

    def validate
      return if item.class.name.demodulize == 'SelectItem'
      raise ArgumentError, 'not a valid SelectItem object'
    end
  end
end
