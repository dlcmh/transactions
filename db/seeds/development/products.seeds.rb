max_records = 10_000
current_records = Product.count

((current_records + 1)..max_records).each do |_|
  Product.create! name: Faker::Book.title,
                  price: "#{1 + rand(999)}.#{rand(10)}#{rand(10)}",
                  categories: Category.all.sample(1 + rand(6))
end
