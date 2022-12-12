Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'home/index'
  # devise_for :user_gens
  mount RailsAdmin::Engine => '//admin', as: 'rails_admin'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "welcome/index"
  get "welcome/blog"
  get "welcome/blog_single"
  get "welcome/cart"
  get "welcome/checkout"
  get "welcome/contact_us"
  get "welcome/login"
  # get "welcome/product_details"\
  get 'welcome/product_details/:id', to: 'welcome#product_details', as: 'product_details'
  post 'welcome/create',to: 'welcome#create'

  get "welcome/shop"
  get "welcome/error404"
  resources :categories
  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"

  post 'products/:id/add' => "products#add_quantity", as: "add_quantity"
  post 'products/:id/minus' => "products#dec_quantity", as: "dec_quantity"
  # post 'products/:id/add' => "products#add_quantity", as: "add_quantity"

  # Defines the root path route ("/")
  root "home#index"
end
