class MonthlySalesTotal < Query
  private

  def query
    <<~SQL.freeze
      SELECT
        TO_CHAR(DATE_TRUNC('month', date), 'DD-MON-YYYY') AS first_day_of_month,
        SUM(quantity * unit_price) sales_amount
      FROM transactions
      GROUP BY DATE_TRUNC('month', date)
      ORDER BY DATE_TRUNC('month', date) DESC
    SQL
  end
end
