class CartController < ApplicationController
  def show
    @cart_items = Product.find(cart.keys)
  end

  def add
    product_id = params[:id].to_s
    quantity = params[:quantity].to_i
    cart[product_id] = (cart[product_id] || 0) + quantity
    redirect_to products_path, notice: "Added #{quantity} to cart."
  end

  def remove
    cart.delete(params[:id].to_s)
    redirect_to cart_path, notice: "Removed from cart."
  end
end