class TopSellingProducts < Query
  def products
    Qry.from <<~SQL.freeze
      SELECT id, name FROM products
    SQL
  end

  # can run `TopSellingProducts.sales.limit 10` in the console
  def sales
    Qry.from <<~SQL.freeze
      SELECT
        product_id,
        SUM(quantity * unit_price) sales_amount
      FROM transactions
      GROUP BY product_id
    SQL
  end

  def top_ten
    limit 10
  end

  private

  def query
    <<~SQL.freeze
      SELECT
        p.name, s.sales_amount
      FROM #{sales} s
      JOIN #{products} p
      ON p.id = s.product_id
      ORDER BY s.sales_amount DESC
    SQL
  end
end
