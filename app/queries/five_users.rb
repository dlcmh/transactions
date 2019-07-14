class Users < Pgsnap
  def defn
    select :id, :first_name
    limit 5
  end
end
