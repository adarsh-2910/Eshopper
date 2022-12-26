class WelcomeController < ApplicationController
require "stripe"
    def index
      @feature_products = Product.all rescue nil 
      # @category_product = Category.includes(:subcats).all rescue nil
      @category = Category.where(parent_id: nil)
      @baner = Baner.all
    end    

    def wishlist
    end  

    def create
		  @address = current_user.addresses.new(address_params)
      # binding.pry
      # @address.save
      if @address.save
        flash[:success] = "address created successfully!"
        redirect_to welcome_checkout_path
      else
        # puts "#{@address.errors.full_messages}"
        flash.now[:error] = "address not created"
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
        # @address = Address.new
      @address = current_user.addresses.last
    end
    
    def contact_us
    end
    
    def login
    end
    
    def product_details
      @category = Category.find(params[:id]) 
      @products = @category.products
    end
    
    def success
      response = Stripe::Checkout::Session.retrieve(id: params[:session_id])
      # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#{response}"
      @trans_id = response[:payment_intent]
      payable_amt = response[:amount_total]
      @total_amt = payable_amt/100
      amount= payable_amt/100
      @pay_response = current_user.payment_responses.create(transaction_id: response[:payment_intent], amount: amount)

      @products = Product.all
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
      params.require(:address).permit(:address_1,:pincode, :mobile_no, :country, :state)
    end
end
