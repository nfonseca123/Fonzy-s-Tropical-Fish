ActiveAdmin.register Order do
  permit_params :customer_id, :province_id,
                :address_line1, :address_line2, :city, :postal_code,
                :subtotal, :gst_amount, :pst_amount, :hst_amount,
                :tax_total, :total_price,
                :payment_intent_id, :order_status

  index do
    selectable_column
    id_column
    column :customer_id
    column :province
    column :order_status
    column :total_price
    column :created_at
    actions
  end

  filter :order_status
  filter :province
  filter :customer_id
  filter :created_at

  form do |f|
    f.inputs do
      f.input :customer_id
      f.input :province
      f.input :address_line1
      f.input :address_line2
      f.input :city
      f.input :postal_code
      f.input :subtotal
      f.input :gst_amount
      f.input :pst_amount
      f.input :hst_amount
      f.input :tax_total
      f.input :total_price
      f.input :payment_intent_id
      f.input :order_status, as: :select, collection: [ "unpaid", "paid", "shipped" ]
    end
    f.actions
  end
end
