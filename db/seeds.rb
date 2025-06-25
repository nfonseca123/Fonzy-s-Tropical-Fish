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
  Product.create!(
    name: row['name'],
    description: row['description'],
    current_price: row['current_price'],
    stock_quantity: row['stock_quantity'],
    on_sale: row['on_sale'] == 'true'
  )
end

categories_path = Rails.root.join('db', 'categories.csv')

CSV.foreach(categories_path, headers: true) do |row|
  next if row['name'].blank?
  Category.create!(
    name: row['name'],
  )
end

