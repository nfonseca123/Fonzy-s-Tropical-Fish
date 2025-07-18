class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :province
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :phone, presence: true, length: { maximum: 15  }
  validates :address, presence: true, length: { maximum: 255 }

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end
    def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "encrypted_password", "first_name", "id", "id_value", "last_name", "phone", "province_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  def display_name
    "#{first_name} #{last_name} (ID #{id})"
  end
end
