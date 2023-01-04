class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :initialize_session
    before_action :load_cart
  
    private
  
    def initialize_session
      session[:cart] ||= [] # empty cart = empty array session has a cart object
    end

    def load_cart
      @cart = Product.find(session[:cart])
      # binding.pry
    end

    
end
