class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, limit: 100, null: false
      t.text :description
      t.decimal :current_price, precision: 10, scale: 2, null: false
      t.boolean :on_sale, default: false

      t.timestamps
    end
  end
end
