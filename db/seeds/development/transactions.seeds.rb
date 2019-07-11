max_records = 100_000
current_records = Transaction.count

product_ids = Product.ids.shuffle
user_ids = User.ids.shuffle
((current_records + 1)..max_records).each do |_|
  product_id = product_ids.pop
  user_id = user_ids.pop
  if product_id.nil?
    product_ids = Product.ids.shuffle
    product_id = product_ids.pop
  end
  if user_id.nil?
    user_ids = User.ids.shuffle
    user_id = user_ids.pop
  end
  product = Product.find(product_id)
  Transaction.create! user_id: user_id,
                      product: product,
                      unit_price: product.price,
                      quantity: 1 + rand(5),
                      date: Time.zone.now - (rand(731)).day
end
