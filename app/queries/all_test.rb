class AllTest < Pgsnap
  def defn
    select :id, :quantity
    from :transactions
    limit 5
  end
end
