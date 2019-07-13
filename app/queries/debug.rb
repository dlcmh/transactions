class Debug
  def self.run
    select = PgsnapRails::Select.new
    from = PgsnapRails::From.new(:transactions)
    select_list = PgsnapRails::SelectList.new
    select_item = PgsnapRails::SelectItem.new(:*)
    select_list.add(select_item)
    select.add_select_list(select_list)
    select.add_from(from)
    select
  end
end
