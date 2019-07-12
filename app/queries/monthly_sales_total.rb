class MonthlySalesTotal < Query
  private

  def query
    <<~SQL.freeze
      SELECT
        DATE_TRUNC('month', date) AS first_day_of_month,
        SUM(quantity * unit_price) sales_amount
      FROM transactions
      GROUP BY first_day_of_month
      ORDER BY first_day_of_month DESC
    SQL
  end
end
