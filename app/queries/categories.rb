class Categories < Query
  private

  def query
    <<~SQL.freeze
      SELECT id category_id, name FROM categories
    SQL
  end
end
