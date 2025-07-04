# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Example of a simple dashboard with columns and panels.
    para link_to "Create New Product", new_admin_product_path
    columns do
      column do
        panel "All Products" do
          ul do
            Product.order(created_at: :desc).map do |product|
              li link_to(product.name, admin_product_path(product))
            end
          end
        end
      end
    end
  end
end
