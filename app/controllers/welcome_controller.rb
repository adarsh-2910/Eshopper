class WelcomeController < ApplicationController
    def index
        @feature_products = Product.all rescue nil 
        # @category_product = Category.includes(:subcats).all rescue nil
        @category = Category.all
    end    

    def blog
    end
    
    def blog_single
    end
    
    def cart
    end
    
    def checkout
    end
    
    def contact_us
    end
    
    def login
    end
    
    def product_details
        @category = Category.find(params[:id])
        @products = @category.products

    end
    
    def shop
    end
    
    def error404
    end    
    def catprods
        @category = Category.all

    end
end
