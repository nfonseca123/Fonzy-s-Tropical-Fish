class OrdersController < ApplicationController
  def checkout
    if current_customer
      province = current_customer.province
      @province_id = province&.id

      unless province
        redirect_to root_path, alert: "We couldn't determine your province. Please update your profile." and return
      end

      @province_name = province.name
      @gst_rate = province.gst_rate.to_f / 100
      @pst_rate = province.pst_rate.to_f / 100
      @hst_rate = province.hst_rate.to_f / 100
    else
      @province_name = "Unknown"
      @gst_rate = @pst_rate = @hst_rate = 0
    end

    tax_multiplier = 1 + @gst_rate + @pst_rate + @hst_rate
    @cart_items = Product.find(cart.keys)

    @cart_totals = @cart_items.each_with_object({}) do |product, hash|
      quantity = cart[product.id.to_s].to_i
      price_with_tax = product.current_price * quantity * tax_multiplier
      hash[product.id] = price_with_tax
    end

    @cart_total = @cart_totals.values.sum

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

    if @order
      province = @order.province
      gst_rate = province.gst_rate.to_f / 100
      pst_rate = province.pst_rate.to_f / 100
      hst_rate = province.hst_rate.to_f / 100
      tax_multiplier = 1 + gst_rate + pst_rate + hst_rate

      cart_items = Product.find(cart.keys)
      cart_totals = cart_items.each_with_object({}) do |product, hash|
        quantity = cart[product.id.to_s].to_i
        price_with_tax = product.current_price * quantity * tax_multiplier
        hash[product.id] = price_with_tax
      end

      cart_total = cart_totals.values.sum

      @order.update(
        subtotal: cart_total,
        gst_amount: cart_total * gst_rate,
        pst_amount: cart_total * pst_rate,
        hst_amount: cart_total * hst_rate,
        total_price: cart_total * tax_multiplier,
        order_status: "paid"
      )

      session.delete(:order_id)
      session.delete(:cart)
    else
      redirect_to checkout_url, alert: "Order not found. Please try again."
    end
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