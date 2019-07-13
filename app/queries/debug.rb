class Debug
  def self.run
    select = PgsnapRails::Select.new
    limit = PgsnapRails::Limit.new(5)
    from = PgsnapRails::From.new(:users)
    select_list = PgsnapRails::SelectList.new
    select_item = PgsnapRails::SelectItem.new(:*)
    select_list.add(select_item)
    select.add_limit(limit)
    select.add_from(from)
    select.add_select_list(select_list)
    select.columns
    # select.all
    select
  end
end
