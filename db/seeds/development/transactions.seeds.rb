max_records = 50_000
current_records = Transaction.count

product_ids = Product.ids.shuffle
((current_records + 1)..max_records).each do |_|
  product_id = product_ids.pop
  if product_id.nil?
    product_ids = Product.ids.shuffle
    product_id = product_ids.pop
  end
  product = Product.find(product_id)
  Transaction.create! user_id: User.ids.sample,
                      product: product,
                      unit_price: product.price,
                      quantity: 1 + rand(5),
                      date: Time.zone.now - (rand(731)).day
end
