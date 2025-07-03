class ProductsController < ApplicationController
def index
  @categories = Category.all
  @query = params[:query]
  @selected_category = params[:category_id]
  @new_products = params[:new_products]
  @recently_updated_products = params[:recently_updated_products]

  # Handle "New Products" OR "Recently Updated" — mutually exclusive
  if @new_products == "true"
    @products = Product.where("products.created_at >= ?", 3.days.ago)
  elsif @recently_updated_products == "true"
    @products = Product.where("products.updated_at >= ?", 1.day.ago)
  else
    @products = Product.all
  end

  # Apply search filter if present
  if @query.present?
    @products = @products.where("products.name LIKE :q OR products.description LIKE :q", q: "%#{@query}%")
  end

  # Apply category filter if present
  if @selected_category.present?
    @products = @products.joins(:categories).where(categories: { id: @selected_category })
  end

  @products = @products.page(params[:page]).per(5)
end

  def show
    @product = Product.find(params[:id])
  end
end
