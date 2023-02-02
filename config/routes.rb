Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount RailsAdmin::Engine => '//admin', as: 'rails_admin'
  root 'home#index'
  resources :home, only: [:index] do
    collection do
      post 'mailchimp'
    end
  end

  resources :contact, only: [:index, :create]
  resources :wishlist, only: [:index, :create, :destroy]

  
  get "welcome/index"
  get "welcome/blog"
  get "welcome/blog_single"
  
  get "welcome/cart"
  get "welcome/checkout"
  get "welcome/contact"
  post "welcome/contact_us"

  get "welcome/login"
  get "welcome/order", to: 'welcome#order'
  get "products/show"

  # post 'home/mailchimp', to:'home#mailchimp', as: 'mailchimp'

  get 'welcome/product_details/:id', to: 'welcome#product_details', as: 'product_details'
  post 'welcome/create',to: 'welcome#create'
  get 'welcome/success', to: 'welcome#success', as: "shop_success"
  post 'welcome/create',to: 'welcome#create'

  get "welcome/stripe", to: "welcome#stripe"
  get "welcome/track"
  post "welcome/track"
  get 'welcome/cod'
  get 'welcome/checkout_product', to: "welcome#checkout_product"
  
  post "welcome/cart"
  post "profile/update", to: "profile#update", as: "profile_update"
  get "welcome/myaccount"
  get "welcome/shop"
  get "welcome/error404"
  resources :categories
  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"
  delete 'products/remove_product/:id', to: "products#remove_product", as: "remove_product"

  post '/new/:id', to: "user_wish_list#new", as: "new"
  # delete "user_wish_list/remove_wishlist/:id", to:  "user_wish_list#remove_wishlist", as: "remove_wishlist"
  # get'products/wishlist'

  post 'products/:id/add' => "products#add_quantity", as: "add_quantity"
  post 'products/:id/minus' => "products#dec_quantity", as: "dec_quantity"
  
  # Defines the root path route ("/")
  # root "home#index"
end
