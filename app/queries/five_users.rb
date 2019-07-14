class FiveUsers < Pgsnap
  def defn
    from Users
    select :id, :first_name
    limit 5
  end
end
