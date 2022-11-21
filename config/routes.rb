Rails.application.routes.draw do
  mount RailsAdmin::Engine => '//admin', as: 'rails_admin'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "welcome/index"
  get "welcome/blog"
  get "welcome/blog_single"
  get "welcome/cart"
  get "welcome/checkout"
  get "welcome/contact_us"
  get "welcome/login"
  get "welcome/product_details"
  get "welcome/shop"
  get "welcome/error404"
  

  # Defines the root path route ("/")
  # root "users#sign_up"
end
