class BestsellingAuthors < Query
  def top_ten
    where('top_ranked <= 10')
    order(top_ranked: :asc)
  end

  private

  # http://www.postgresqltutorial.com/postgresql-window-function/
  def query
    <<~SQL.freeze
      SELECT
        p.product_id,
        p.category_names authors,
        s.sales_amount,
        RANK() OVER (
          ORDER BY sales_amount DESC
        ) top_ranked
      FROM #{TotalSalesByProduct.new} s
      NATURAL JOIN #{CategoriesOfProducts.new} p
    SQL
  end
end
