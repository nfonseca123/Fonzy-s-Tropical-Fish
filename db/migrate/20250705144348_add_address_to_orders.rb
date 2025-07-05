class AddAddressToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :address_line1, :string
    add_column :orders, :address_line2, :string
    add_column :orders, :city, :string
    add_column :orders, :postal_code, :string
  end
end
