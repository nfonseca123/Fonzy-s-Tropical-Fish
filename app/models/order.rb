class Order < ApplicationRecord
  has_many :orderitems, dependent: :destroy
  belongs_to :customer, optional: true
  belongs_to :province, optional: true


  validates :address_line1, :city, :postal_code, presence: true
  validates :province, presence: true

  validates :order_status, presence: true, inclusion: { in: %w[unpaid paid shipped] }


  validates :subtotal, numericality: { greater_than_or_equal_to: 0 }
  validates :gst_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :pst_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :hst_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "address_line1", "address_line2", "city", "created_at", "customer_id", "gst_amount", "hst_amount", "id", "id_value", "order_status", "payment_intent_id", "postal_code", "province_id", "pst_amount", "subtotal", "tax_total", "total_price", "updated_at" ]
  end
  def self.ransackable_associations(auth_object = nil)
    [ "customer", "orderitems", "province" ]
  end
end
