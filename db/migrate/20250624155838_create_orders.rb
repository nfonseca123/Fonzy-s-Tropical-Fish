class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true

      t.decimal :subtotal, precision: 10, scale: 2, null: false
      t.decimal :gst_amount, precision: 10, scale: 2
      t.decimal :pst_amount, precision: 10, scale: 2
      t.decimal :hst_amount, precision: 10, scale: 2
      t.decimal :tax_total, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2, null: false

      t.string :payment_id, limit: 255
      t.string :payment_provider, limit: 50
      t.string :order_status, limit: 50, null: false

      t.timestamps
    end
  end
end