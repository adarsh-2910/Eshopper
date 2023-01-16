class ApplicationController < ActionController::Base
    
    before_action :authenticate_user!
    before_action :initialize_session
    before_action :load_cart
    before_action :set_cms
    before_action :configure_permitted_parameters, if: :devise_controller?
    

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end
  
    def initialize_session
      session[:cart] ||= [] # empty cart = empty array session has a cart object
    end

    def load_cart
      @cart = Product.find(session[:cart])
      # binding.pry
    end
    
    def set_cms
      @cms = Cm.all
    end

end
