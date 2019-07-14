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
      self
    end

    def with(*items)
      validate_with(items)
      items.each do |item|
        @items << PgsnapRails::SelectItem.new(item)
      end
      self
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

    def validate_with(items)
      return if items.is_a?(Array)
      raise ArgumentError, "#{items} is not a valid Array"
    end
  end
end
