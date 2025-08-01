Rails.application.routes.draw do
  get "orders/process_checkout"
  get "orders/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :customers, controllers: {
    registrations: "customers/registrations",
    sessions: "customers/sessions"
  }

  root to: "home#index"

  resources :products

  get "cart", to: "cart#show"
  post "cart/add/:id", to: "cart#add", as: "add_to_cart"
  delete "cart/remove/:id", to: "cart#remove", as: "remove_from_cart"
  match "checkout", to: "orders#checkout", via: [ :get, :post ], as: :checkout
  post "checkout/payment", to: "orders#start_payment", as: :start_payment
  get "order/success", to: "orders#success", as: :order_success
  resources :orders, only: [ :index, :show ]
end
