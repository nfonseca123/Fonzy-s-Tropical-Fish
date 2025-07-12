class AddTaxRatesToOrderItems < ActiveRecord::Migration[8.0]
  def change
    add_column :orderitems, :gst_rate, :decimal
    add_column :orderitems, :pst_rate, :decimal
    add_column :orderitems, :hst_rate, :decimal
  end
end
