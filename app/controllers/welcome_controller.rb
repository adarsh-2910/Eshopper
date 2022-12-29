class WelcomeController < ApplicationController
require "stripe"
include StripeCheckout
  def index
    @feature_products = Product.all rescue nil 
    # @category_product = Category.includes(:subcats).all rescue nil
    @category = Category.where(parent_id: nil)  
    @baner = Baner.all
  end    

  def wishlist
    @wishlist = UserWishlist.all
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

  def myaccount
  end  
  
  def cart
    
    @product_price = [] 
    @cart.each do |product| 
      temp = (product.quantity)*(product.price)
      @product_price << temp
    end
    @value = @product_price.inject {|sum,price| sum + price}  #o/p is in integer
    if @value < 500
      @shipping_cost = 50
    else
      @shipping_cost = 0
    end

    # @final_shipping_cost = @shipping_cost
    @final_value = @value + @shipping_cost    #total amount affter adding shipping address 
    # checkout_session(@final_value)            #call once
    # binding.pry
    @user = current_user
    @all_coupons = UserCoupon.all
    @entered_code = params[:coupon_code]
    user_c = UserCoupon.find_by(coupon_code: @entered_code)
    # coupon_used = 0
    # binding.pry
    
    
    @all_coupons.each do |c|
      if @entered_code == c.coupon_code     #checking if entered code matches with the record
        if @user.user_coupons.include?(user_c)   #checking if current_user have this coupon
          # render "cart", notice: "coupon code already applied"
          puts "######################################## coupon code applied already"
        else
          puts "########################################valid coupon applied"
          # binding.pry
          user_c.no_of_uses += 1   #incrementing that particular coupon used
          @user.user_coupons << user_c              #appending that coupon in coupon used
          # @final = user_c.update(final_price: @total_value_coupon)
          @total_value_coupon = @final_value - (@final_value*(user_c.percent_off)/100) 
          
          # binding.pry
          # binding.pry
        # render "cart", notice: "coupon code applied successfully"
        # binding.pry
      
        # binding.pry
        
      end
      else
        # render "cart", notice: "invalid"
        
        puts "#########################################################invalid"
      end          
    end
    #@final_value
    #@total_value_coupon
    binding.pry
	end
  
  def checkout
      # @address = Address.new
    cart
    product_price_lists = [] 	
    products = Product.where(id: @cart.map(&:id))     #map { |@cart| @cart.product.id }
    order = UserOrder.create(user_id: current_user.id)
    # binding.pry
    if order.save
      products.each do |product|
        order.order_details.create(product_id: product.id , amount: product.price ,quantity: product.quantity)
        @total = (product.quantity)*(product.price)
        product_price_lists << @total
      end
    end
    # @final_value
    order.grand_total = @final_value
    order.save
    # binding.pry
    # stripe(order)
    # total_price = product_price_lists.inject {|sum,price| sum + price}
    # @value = total_price.to_i  
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
    params.permit(:address_1,:pincode, :mobile_no, :country, :state)
  end
end
