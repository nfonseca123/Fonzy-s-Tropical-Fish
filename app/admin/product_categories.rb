ActiveAdmin.register ProductCategory do
  permit_params :product_id, :category_id
  menu false


  index do
    selectable_column
    id_column
    column :product
    column :category
    actions
  end

  form do |f|
    f.inputs do
      f.input :product
      f.input :category
    end
    f.actions
  end
end
