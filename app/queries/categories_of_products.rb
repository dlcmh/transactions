class CategoriesOfProducts < Query
  private

  def query
    <<~SQL.freeze
      SELECT
        p.product_id,
        p.product_name,
        JSON_AGG(c.name) category_names
      FROM categorizations n
      INNER JOIN #{Products.new} p USING (product_id)
      INNER JOIN #{Categories.new} c USING (category_id)
      GROUP BY p.product_id, p.product_name
    SQL
  end
end
