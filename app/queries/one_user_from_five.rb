class OneUserFromFive < Pgsnap
  def defn
    from FiveUsers
    limit 1
  end
end
