# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'csv'
require 'faker'

provinces_path = Rails.root.join('db', 'provinces.csv')

CSV.foreach(provinces_path, headers: true) do |row|
  Province.create!(
    name: row['name'],
    gst_rate: row['gst_rate'],
    pst_rate: row['pst_rate'],
    hst_rate: row['hst_rate']
  )
end

products_path = Rails.root.join('db', 'products.csv')

CSV.foreach(products_path, headers: true) do |row| next if row['name'].blank?
  product = Product.create!(
    name: row['name'],
    description: row['description'],
    current_price: row['current_price'],
    stock_quantity: row['stock_quantity'],
    on_sale: row['on_sale'] == 'true'
  )

  image_path = Rails.root.join(row['image_path'])
  if File.exist?(image_path)
    product.image.attach(io: File.open(image_path), filename: File.basename(image_path), content_type: "image/jpeg")
  else
    puts "Image not found for #{row['name']}"
  end
end

categories_path = Rails.root.join('db', 'categories.csv')

CSV.foreach(categories_path, headers: true) do |row|
  next if row['name'].blank?
  Category.create!(
    name: row['name'],
  )
end

30.times do
  ProductCategory.create!(
    product_id: Product.order('RANDOM()').first.id,
    category_id: Category.order('RANDOM()').first.id
  )
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?