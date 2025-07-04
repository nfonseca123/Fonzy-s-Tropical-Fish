ActiveAdmin.register Product do
  # Permit parameters for strong assignment
  permit_params :name, :description, :current_price, :stock_quantity, :on_sale, :image, category_ids: []
  menu false
  actions :all

  index do
    selectable_column
    id_column
    column :name
    column :current_price
    column :stock_quantity
    column :on_sale
    column "Image" do |product|
      if product.image.attached?
        image_tag product.image, size: "50x50"
      else
        "No Image"
      end
    end
  end


  show do
    attributes_table do
      row :name
      row :description
      row :current_price
      row :stock_quantity
      row :on_sale
      row :categories do |product|
        product.categories.map(&:name).join(", ")
      end
      row "Image" do |product|
        if product.image.attached?
          image_tag product.image
        else
          "No Image"
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :current_price
      f.input :stock_quantity
      f.input :on_sale
      f.input :image, as: :file
      f.input :categories, as: :check_boxes, collection: Category.all
    end
    f.actions
  end
end
