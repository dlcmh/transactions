class Users < Pgsnap
  def defn
    select :id
    limit 5
  end
end
