class WelcomeController < ApplicationController
require "stripe"
include StripeCheckout

  def index
    @feature_products = Product.all rescue nil 
    # @category_product = Category.includes(:subcats).all rescue nil
    @category = Category.where(parent_id: nil)  
    @baner = Baner.all
    @cms = Cm.all
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

    @final_value = @value + @shipping_cost    #total amount affter adding shipping address 
    @user = current_user
    @all_coupons = UserCoupon.all
    @entered_code = params[:coupon_code]
    user_c = UserCoupon.find_by(coupon_code: @entered_code)
    
    @all_coupons.each do |c|
      if @user.user_coupons.include?(user_c) 
         flash[:message] = "Coupon already applied !"
      
      elsif @entered_code == c.coupon_code
          user_c.no_of_uses += 1  
          @user.user_coupons << user_c     
          @f_value = @final_value - (@final_value*(user_c.percent_off)/100)
          @@f_value = @f_value
          flash[:message] = "Coupon applied successfully!"
      else
          @f_value = @final_value
          @@f_value = @final_value
      end
    end  
    end



  def stripe
    checkout_product
    # binding.pry
    product=Stripe::Product.create({name: 'Order 1'})
    Stripe::Price.create({
    unit_amount: @@f_value,
    # product: {{product.id}},
    currency: 'usd',
    product: product.id,
    })
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [
        price_data: {
        product: product.id,
        unit_amount: @@f_value*100,
        currency: 'usd'
      },
      quantity: 1,
      ],
      mode: 'payment',
      success_url: 'http://localhost:3000/welcome/success?true&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,
      })
      
      
    end
  
    def checkout
    end


    def checkout_product
    
    amount = @@f_value
    address = current_user.addresses.last
    product_price_lists = [] 	
		products = Product.where(id: @cart.map(&:id))
		order = UserOrder.create(user_id: current_user.id, grand_total: amount)
		if order.save
			products.each do |product|
				ord = order.order_details.create(product_id: product.id, amount:product.price, quantity: product.quantity)
				total = (product.quantity)*(product.price)
		  	product_price_lists << total
      end
      UserMailer.send_order_details(current_user,order).deliver
      UserMailer.send_order_details_admin(current_user,order).deliver
    end
    
  end
  
  def contact
    @cont = ContactU.last
  end

  def contact_us
    @contact=ContactU.new(contact_params)
    @cont = ContactU.last
    if @contact.save
      flash[:success] = "New adress successfully added!"
      redirect_to welcome_contact_path
    else
      flash.now[:error] = "adress creation failed"
      render:new
  end
end
  
  def login
  end


  def track
    # binding.pry
    @user_order = UserOrder.find_by(id: params[:user_order_id])
		unless @user_order.present?
      @error = "User order not found"
    end
  end  

  def order
      @orders = current_user.user_orders.all      #current_user.user_orders
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

  def contact_params
		params.permit(:name,:email,:contact_no,:message)
	end
end
