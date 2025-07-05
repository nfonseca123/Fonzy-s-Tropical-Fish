class OrdersController < ApplicationController
  def checkout
    @cart_items = Product.find(cart.keys)
    @cart_totals = @cart_items.each_with_object({}) do |product, hash|
      quantity = cart[product.id.to_s]
      hash[product.id] = product.current_price * quantity
    end
    @cart_total = @cart_totals.values.sum
    @order = Order.new
  end

  def start_payment
  session = Stripe::Checkout::Session.create(
    payment_method_types: ["card"],
    line_items: build_line_items,
    mode: "payment",
    success_url: order_success_url,
    cancel_url: checkout_url
  )

  redirect_to session.url, allow_other_host: true
  end

  def success
    @order = Order.find_by(id: session[:order_id])
    session.delete(:cart)
  end


  def show
    @order = Order.find(params[:id])
  end

  private

  def build_line_items
    Product.find(cart.keys).map do |product|
      {
        price_data: {
          currency: "cad",
          product_data: {
            name: product.name
          },
          unit_amount: (product.current_price * 100).to_i
        },
        quantity: cart[product.id.to_s]
      }
    end
  end


end