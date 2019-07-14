class Debug
  def self.select_kw
    Users.select(:id)
    Users.select(:id).columns
    Users.select(:id, :first_name, :last_name).limit(3).all
  end

  def self.items
    select = PgsnapRails::Select.new
    select_list = PgsnapRails::SelectList.new
    select_list.with(:id, :first_name, '1 AS one')
    select.add_to_tree(select_list)
    select.add_to_tree PgsnapRails::From.new(:users)
    select.add_to_tree PgsnapRails::Limit.new(4)
    select
    select.all
  end

  def self.build_missing
    Users.limit(10).columns
    # Pgsnap.table(:categories).limit(10).all
  end

  def self.keywords
    Pgsnap.table(:categories).limit(10).columns
    # Pgsnap.table(:categories).limit(10).all
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
