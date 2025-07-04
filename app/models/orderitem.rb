class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price_at_time_of_order, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
