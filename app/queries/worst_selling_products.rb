class WorstSellingProducts < Query
  def products
    Qry.from <<~SQL.freeze
      SELECT id, name FROM products
    SQL
  end

  def sales
    Qry.from <<~SQL.freeze
      SELECT
        product_id,
        SUM(quantity * unit_price) sales_amount
      FROM transactions
      GROUP BY product_id
    SQL
  end

  def bottom_ten
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
      ORDER BY s.sales_amount ASC
    SQL
  end
end
