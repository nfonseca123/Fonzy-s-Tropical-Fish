class Province < ApplicationRecord
  has_many :customers
  has_many :orders

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :gst_rate, numericality: { greater_than_or_equal_to: 0 }
  validates :pst_rate, numericality: { greater_than_or_equal_to: 0 }
  validates :hst_rate, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "gst_rate", "hst_rate", "id", "id_value", "name", "pst_rate", "updated_at" ]
  end
end
