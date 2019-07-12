class BestsellingAuthors < Query
  def top_ten
    where('ranking <= 10')
    order(ranking: :asc)
  end

  private

  # http://www.postgresqltutorial.com/postgresql-window-function/
  def query
    <<~SQL.freeze
      SELECT
        p.product_name book_title,
        p.category_names authors,
        RANK() OVER (
          ORDER BY sales_amount DESC
        ) ranking,
        s.sales_amount,
        p.category_count author_count,
        ROUND((s.sales_amount / p.category_count), 2) attributable_sale_per_author
      FROM #{TotalSalesByProduct.new} s
      NATURAL JOIN #{CategoriesOfProducts.new} p
    SQL
  end
end
