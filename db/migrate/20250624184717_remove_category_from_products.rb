class RemoveCategoryFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_reference :products, :category, null: false, foreign_key: true
  end
end
