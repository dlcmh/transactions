class MonthlySalesTotal < Query
  private

  def query
    <<~SQL.freeze
      SELECT
        DATE_TRUNC('month', date) AS first_day,
        SUM(quantity * unit_price)
      FROM transactions
      GROUP BY first_day
      ORDER BY first_day DESC
    SQL
  end
end
