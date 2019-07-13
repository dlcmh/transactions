class Debug
  def self.keywords
    Pgsnap.table(:categories).limit(10).all
  end

  def self.select_test
    select = PgsnapRails::Select.new
    table = PgsnapRails::Table.new(:categories)
    # select.add_table(table)
    select.add_to_tree(table)
    select
  end

  def self.run
    select = PgsnapRails::Select.new

    table = PgsnapRails::Table.new(:categories)
    limit = PgsnapRails::Limit.new(5)
    from = PgsnapRails::From.new(:users)

    select_list = PgsnapRails::SelectList.new
    select_item = PgsnapRails::SelectItem.new(:*)
    select_list.add(select_item)

    # select.add_to_tree(table)
    select.add_to_tree(limit)
    select.add_to_tree(from)
    select.add_to_tree(select_list)

    p select.columns
    # select.all

    select
  end
end
