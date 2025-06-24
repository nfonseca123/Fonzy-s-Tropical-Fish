class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces, id: false do |t|
      t.primary_key :province_id
      t.string :name, limit: 50, null: false
      t.decimal :gst_rate, precision: 10, scale: 2
      t.decimal :pst_rate, precision: 10, scale: 2
      t.decimal :hst_rate, precision: 10, scale: 2

      t.timestamps
    end
  end
end