class ProductsController < ApplicationController
def index
  @categories = Category.all
  @query = params[:query]
  @selected_category = params[:category_id]
  @new_products = params[:new_products]
  @recently_updated_products = params[:recently_updated_products]
  @on_sale = params[:on_sale]

  # Handle "New Products" OR "Recently Updated"
  if @new_products == "true"
    @products = Product.where("products.created_at >= ?", 3.days.ago)
  elsif @recently_updated_products == "true"
    @products = Product.where("products.updated_at >= ?", 3.day.ago)
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
  # Apply on sale filter if present
  if @on_sale == "true"
    @products = @products.where(on_sale: true)
  end
  @products = @products.page(params[:page]).per(8)
end

  def show
    @product = Product.find(params[:id])
  end
end
