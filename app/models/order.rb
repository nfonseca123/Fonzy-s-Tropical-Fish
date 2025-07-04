class Order < ApplicationRecord
  has_many :orderitems
  belongs_to :customer
  belongs_to :province
  validates subtotal: { numericality: { greater_than_or_equal_to: 0 } }
  validates gst_amount: { numericality: { greater_than_or_equal_to: 0 } }
  validates pst_amount: { numericality: { greater_than_or_equal_to: 0 } }
  validates hst_amount: { numericality: { greater_than_or_equal_to: 0 } }
  validates total_price: { numericality: { greater_than_or_equal_to: 0 } }
  validates payment_id: { presence: true, uniqueness: true }
  validates order_status: { presence: true, inclusion: { in: %w[pending paid shipped completed cancelled] } }s
end
