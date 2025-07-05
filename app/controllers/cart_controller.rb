class CartController < ApplicationController
  def show
    @cart_items = Product.find(cart.keys)

    @cart_totals = @cart_items.each_with_object({}) do |product, hash|
      quantity = cart[product.id.to_s]
      hash[product.id] = product.current_price * quantity
    end

    @cart_total = @cart_totals.values.sum
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
