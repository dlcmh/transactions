max_records = 5_000
current_records = User.count

((current_records + 1)..max_records).each do |_|
  User.create! first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name
end
