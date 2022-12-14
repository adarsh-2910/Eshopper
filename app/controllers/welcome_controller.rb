class WelcomeController < ApplicationController
    def index
        @feature_products = Product.all rescue nil 
        # @category_product = Category.includes(:subcats).all rescue nil
        @category = Category.all
        @address = Address.all
    end    

    def create
		@address = current_user.addresses.build(address_params)
        if @address.save
            flash[:success] = "item successfully created!"
            redirect_to welcome_checkout_path
        else
            puts "#{@address.errors.full_messages}"
            flash.now[:error] = "item creation failed"
            render "welcome/checkout"
        end
    end

    def blog
    end
    
    def blog_single
    end
    
    def cart
        @product_price_lists = [] 
		@cart.each do |product| 
		temp = (product.quantity)*(product.price)
		@product_price_lists << temp
		end
		@total_price = @product_price_lists.inject {|sum,price| sum + price}
		@value = @total_price.to_i
    end
    
    def checkout
        @address = Address.new
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

    private
    def address_params   #used in User_address
        params.require(:address).permit(:address_1,:pincode, :mobile_no, :country, :state,:city )
    end
end
