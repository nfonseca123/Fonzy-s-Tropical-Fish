class Product < ApplicationRecord
  has_many :orderitems, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :current_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :on_sale, inclusion: { in: [ true, false ] }
  def self.ransackable_associations(auth_object = nil)
    [ "categories", "image_attachment", "image_blob", "orderitems", "product_categories" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "current_price", "description", "id", "id_value", "name", "on_sale", "stock_quantity", "updated_at" ]
  end
end
