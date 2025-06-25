class Order < ApplicationRecord
  has_many :orderitems
  belongs_to :customer
  belongs_to :province
end
