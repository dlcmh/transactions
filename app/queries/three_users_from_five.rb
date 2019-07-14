class ThreeUsersFromFive < Pgsnap
  def defn
    from FiveUsers
    limit 3
  end
end
