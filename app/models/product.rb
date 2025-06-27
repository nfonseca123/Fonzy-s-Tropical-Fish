class Product < ApplicationRecord
  has_many :orderitems, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories, dependent: :destroy
  has_one_attached :image, dependent: :destroy
end