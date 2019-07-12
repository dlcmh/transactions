# https://stackoverflow.com/questions/40048369/postgresql-query-to-get-count-per-months-within-one-year
class Months < Query
  def descending_months
    order(year: :desc, month: :desc)
  end

  private

  def query
    <<~SQL.freeze
      SELECT
        TO_CHAR(series, 'yyyy') AS year,
        TO_CHAR(series, 'mm') AS month,
        DATE_TRUNC('month', series) AS first_day_of_month
      FROM GENERATE_SERIES(NOW() - INTERVAL '1 YEAR', NOW(), '1 MONTH') AS series
    SQL
  end
end
