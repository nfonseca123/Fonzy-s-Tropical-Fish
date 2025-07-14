class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price_at_time_of_order, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "gst_rate", "hst_rate", "id", "id_value", "order_id", "price_at_time_of_order", "product_id", "pst_rate", "quantity", "updated_at" ]
  end
end
