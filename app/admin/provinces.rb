ActiveAdmin.register Province do
  permit_params :name, :gst_rate, :pst_rate, :hst_rate

  index do
    selectable_column
    id_column
    column :name
    column :gst_rate
    column :pst_rate
    column :hst_rate
    column :created_at
    actions
  end

  filter :name
  filter :gst_rate
  filter :pst_rate
  filter :hst_rate
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
    end
    f.actions
  end
end
