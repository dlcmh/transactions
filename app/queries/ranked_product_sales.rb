class RankedProductSales < Query
  def top_and_bottom_ten
    where('top_ranked <= 10 OR bottom_ranked <= 10')
    order(top_ranked: :asc)
  end

  private

  # http://www.postgresqltutorial.com/postgresql-window-function/
  def query
    <<~SQL.freeze
      SELECT
        p.product_id,
        p.product_name,
        s.sales_amount,
        RANK() OVER (
          ORDER BY sales_amount DESC
        ) top_ranked,
        RANK() OVER (
          ORDER BY sales_amount ASC
        ) bottom_ranked
      FROM #{TotalSalesByProduct.new} s
      NATURAL JOIN #{Products.new} p
    SQL
  end
end
