Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Active Admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: "customers/sessions"
  }

  root to: 'home#index'
  get "/custom_logout", to: "sessions#custom_destroy", as: :custom_logout
end