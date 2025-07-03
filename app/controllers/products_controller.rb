class ProductsController < ApplicationController
def index
  @products = Product.all
  @categories = Category.all
  @query = params[:query]
  @products = @products.where("products.name LIKE :q OR products.description LIKE :q", q: "%#{@query}%")

  @selected_category = params[:category_id]
  if @selected_category.present?
    @products = @products.joins(:categories).where(categories: { id: @selected_category })
  end
end

  def show
    @product = Product.find(params[:id])
  end
end
