class RemovePaymentColumnsFromOrders < ActiveRecord::Migration[8.0]
  def change
    remove_column :orders, :payment_id, :string
    remove_column :orders, :payment_provider, :string
  end
end
