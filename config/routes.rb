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

  # get "welcome/product_details"
  get 'welcome/product_details/:id', to: 'welcome#product_details', as: 'product_details'
  post 'welcome/create',to: 'welcome#create'
  get 'welcome/success', to: 'welcome#success', as: "shop_success"
  post 'welcome/create',to: 'welcome#create'

  get "welcome/stripe", to: "welcome#stripe"
  # get 'checkouts', to: "welcome#stripe"
  # get 'billing', to: "billing#show"
  # get 'checkouts/stripe'

  #for stripe
  # get 'checkouts', to: "checkouts#stripe"
  # get 'billing', to: "billing#show"
  # get 'checkouts/stripe'
  # get 'checkouts/show'
  get 'checkouts/cod', to: "checkouts#cod"
  # get 'cod', to: "welcome#cod"
  #for cod
  # post "welcome/create", to: "welcome#create"
  #coupon
  post "welcome/cart"

  #my account
  post "profile/update", to: "profile#update", as: "profile_update"
  # delete "user_wish_list/remove_wishlist/:id", to:  "user_wish_list#remove_wishlist", as: "remove_wishlist"
  get "welcome/myaccount"
  get "welcome/shop"
  get "welcome/error404"
  resources :categories
  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"
  delete 'products/remove_product/:id', to: "products#remove_product", as: "remove_product"

  # wishlist
  post '/new/:id', to: "user_wish_list#new", as: "new"
  delete "user_wish_list/remove_wishlist/:id", to:  "user_wish_list#remove_wishlist", as: "remove_wishlist"
  get'products/wishlist'

  # post 'products/add_to_wishlist/:id', to: "products#add_to_wishlist", as: "add_to_wishlist"
  # delete "products/remove_from_wishlist/:id", to: "products#remove_from_wishlist", as: "remove_from_wishlist"
  post 'products/:id/add' => "products#add_quantity", as: "add_quantity"
  post 'products/:id/minus' => "products#dec_quantity", as: "dec_quantity"
  
  
  # Defines the root path route ("/")
  root "welcome#index"
end
