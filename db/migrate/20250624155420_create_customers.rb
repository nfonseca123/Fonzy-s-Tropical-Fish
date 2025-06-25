class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.references :province, null: false, foreign_key: true
      t.string :first_name, null: false, limit: 50
      t.string :last_name, null: false, limit: 50
      t.string :email, null: false, limit: 50
      t.string :phone, limit: 20
      t.string :encrypted_password, null: false, limit: 100
      t.string :address, null: false, limit: 255

      t.timestamps
    end
  end
end