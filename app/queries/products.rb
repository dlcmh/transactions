class Products < Query
  private

  def query
    <<~SQL.freeze
      SELECT id product_id, name product_name FROM products
    SQL
  end
end
