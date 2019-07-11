max_records = 1_000
current_records = Category.count

((current_records + 1)..max_records).each do |_|
  Category.create! name: Faker::Book.author
end
