class Order < ApplicationRecord
  has_many :orderitems, dependent: :destroy
  belongs_to :customer, optional: true
  belongs_to :province, optional: true


  validates :address_line1, :city, :postal_code, presence: true
  validates :province, presence: true

  validates :payment_id, presence: true, uniqueness: true
  validates :order_status, presence: true, inclusion: { in: %w[pending paid shipped completed cancelled] }


  validates :subtotal, numericality: { greater_than_or_equal_to: 0 }
  validates :gst_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :pst_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :hst_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
end