class UserMailer < ApplicationMailer
  def confirmation_email(customer, order)
    @customer = customer
    @order = order
    mail(to: @customer.email, subject: "Thank you for your order!")
  end
end
