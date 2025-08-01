class OrdersController < ApplicationController
  def index
    @orders = current_customer.orders.includes(:orderitems, :province)
  end

  def checkout
    @order_params = params.permit(
      :address_line1, :address_line2, :city, :province_id,
      :postal_code
    )

    province = Province.find_by(id: @order_params[:province_id])
    return redirect_to checkout_url, alert: "Invalid province" unless province

    @province_id = province.id
    @province_name = province.name
    @gst_rate = province.gst_rate.to_f / 100
    @pst_rate = province.pst_rate.to_f / 100
    @hst_rate = province.hst_rate.to_f / 100

    tax_multiplier = 1 + @gst_rate + @pst_rate + @hst_rate

    @cart_items = Product.find(cart.keys)

    @cart_totals = @cart_items.each_with_object({}) do |product, hash|
      quantity = cart[product.id.to_s].to_i
      hash[product.id] = (product.current_price * quantity).round(2)
    end

    @cart_subtotal = @cart_totals.values.sum.round(2)

    @gst_amount = (@cart_subtotal * @gst_rate).round(2)
    @pst_amount = (@cart_subtotal * @pst_rate).round(2)
    @hst_amount = (@cart_subtotal * @hst_rate).round(2)
    @tax_total = @gst_amount + @pst_amount + @hst_amount
    @total_price = (@cart_subtotal + @tax_total).round(2)
  end

  def start_payment
    order_params = params.permit(
      :address_line1, :address_line2, :city, :province_id,
      :postal_code, :subtotal, :gst_amount, :pst_amount,
      :hst_amount, :tax_total, :total_price, :order_status
    )

    @order = Order.create(
      address_line1: order_params[:address_line1],
      address_line2: order_params[:address_line2],
      city: order_params[:city],
      province_id: order_params[:province_id],
      postal_code: order_params[:postal_code],
      subtotal: order_params[:subtotal],
      gst_amount: order_params[:gst_amount],
      pst_amount: order_params[:pst_amount],
      hst_amount: order_params[:hst_amount],
      tax_total: order_params[:tax_total],
      total_price: order_params[:total_price],
      order_status: order_params[:order_status],
      customer_id: current_customer.id
    )

    if @order.persisted?
      Rails.logger.info "Order created with id: #{@order.id}"
    else
      Rails.logger.error "Order creation failed: #{@order.errors.full_messages.join(', ')}"
    end

    @order_id = @order.id

    stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: build_line_items(@order.province),
      mode: "payment",
      success_url: "#{order_success_url}?order_id=#{@order_id}",
      cancel_url: checkout_url
    )
    redirect_to stripe_session.url, allow_other_host: true
  end

  def success
    # Update the order status to paid
    @order = Order.find_by(id: params[:order_id])

    stripe_session = Stripe::Checkout::Session.list({ limit: 1 }).data.find do |s|
      s.success_url.include?("order_id=#{@order.id}")
    end

    if stripe_session&.payment_intent
      @order.update(payment_intent_id: stripe_session.payment_intent)
    end

    @order.update(order_status: "paid")

    # Clear the cart after successful payment
    @cart = session[:cart] || {}
    @cart_items = Product.where(id: @cart.keys)
    @cart_items.each do |product|
      # Update stock quantity
      quantity = @cart[product.id.to_s].to_i
      if quantity > 0
        old_stock = product.stock_quantity
        new_stock = old_stock - quantity
        product.update(stock_quantity: new_stock)
        Rails.logger.info "Updated #{product.name} stock: #{old_stock} → #{new_stock}"
      end
      # Update order items table
      Orderitem.create!(
        order_id: @order.id,
        product_id: product.id,
        quantity: quantity,
        price_at_time_of_order: product.current_price,
        gst_rate: @order.province.gst_rate,
        pst_rate: @order.province.pst_rate,
        hst_rate: @order.province.hst_rate
      )
    end

    if @order.customer.present? && @order.customer.email.present?
      UserMailer.confirmation_email(@order.customer, @order).deliver_later
      Rails.logger.info "Sent confirmation email to #{@order.customer.email}"
    else
      Rails.logger.warn "No email sent: missing customer or email address"
    end

    session.delete(:cart)
    session.delete(:order_id)

    redirect_to root_path(order_success: true)
  end


  def show
    @order = Order.find(params[:id])
  end

  private


  def build_line_items(province)
    gst_rate = province.gst_rate.to_f / 100
    pst_rate = province.pst_rate.to_f / 100
    hst_rate = province.hst_rate.to_f / 100
    tax_multiplier = 1 + gst_rate + pst_rate + hst_rate

    Product.find(cart.keys).map do |product|
      quantity = cart[product.id.to_s].to_i
      price_with_tax = (product.current_price * tax_multiplier).round(2)

      {
        price_data: {
          currency: "cad",
          product_data: {
            name: product.name
          },
          unit_amount: (price_with_tax * 100).round
        },
        quantity: quantity
      }
    end
  end

  def cart
    session[:cart] ||= {}
  end
end
