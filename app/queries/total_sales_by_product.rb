class TotalSalesByProduct < Query
  private

  def query
    <<~SQL.freeze
      SELECT
        product_id,
        SUM(quantity * unit_price) sales_amount
      FROM transactions
      GROUP BY product_id
    SQL
  end
end
