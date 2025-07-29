ActiveAdmin.register Customer do
  permit_params :first_name, :last_name, :email, :phone, :address, :province_id
  includes orders: :orderitems
  actions :index, :show, :edit, :update, :destroy

  scope :all, default: true
  scope :with_orders do |customers|
    customers.joins(:orders).distinct
  end

  preserve_default_filters!



  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column "Orders" do |customer|
      customer.orders.count
    end
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone
      row :address
    end

    panel "Orders" do
      table_for customer.orders do
        column :id
        column(:date) { |order| order.created_at.to_date }
        column :order_status
        column :subtotal
        column :gst_amount
        column :pst_amount
        column :hst_amount
        column :tax_total
        column :total_price

        column "Products" do |order|
          ul do
            order.orderitems.each do |item|
              li "#{item.quantity}x #{item.product.name} @ $#{item.price_at_time_of_order}"
            end
          end
        end
      end
    end
  end
end
