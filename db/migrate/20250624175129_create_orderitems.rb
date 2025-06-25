class CreateOrderitems < ActiveRecord::Migration[8.0]
  def change
    create_table :orderitems do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.integer :quantity, null: false
      t.decimal :price_at_time_of_order, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
