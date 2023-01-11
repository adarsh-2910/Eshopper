class WelcomeController < ApplicationController
before_action :authenticate_user! , except: [:index]
# validates :first_name, presence: { message: 'name should be present' }
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
    @cms = Cm.all
    @wishlist = UserWishlist.all
  end  

  def create
    # binding.pry
    @address = current_user.addresses.new(address_params)
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
    @cms = Cm.all
    a = UserOrder.last
    # binding.pry
    if a.destroy
      flash[:success] = "record deleted"
      redirect_to welcome_blog_path
    else
      puts "-----------------------#{a.errors.full_messages}-------------------------"
    end
  end
  
  def blog_single
    @cms = Cm.all
  end

  def myaccount
    @cms = Cm.all
  end  
  
  def cart
    @cms = Cm.all
    @product_price = [] 
    @cart.each do |product| 
      temp = (product.quantity)*(product.price)
      @product_price << temp
    end
    @value = @product_price.inject {|sum,price| sum + price}  #o/p is in integer
    @value =  @value.to_i
    if @value < 500 && @value > 0
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
        flash[:message] = "Coupon invalid or already applied!"
      
      elsif @entered_code == c.coupon_code
        user_c.no_of_uses += 1  
        @user.user_coupons << user_c     
        @f_value = @final_value - (@final_value*(user_c.percent_off)/100)
        @@f_value = @f_value
        flash[:message] = "Coupon applied successfully!"

      else
        @f_value = @final_value
        @@f_value = @final_value
        flash[:message] = "Apply coupon if available!"
      end
    end  
    end

  def stripe
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
      @cms = Cm.all
      @address = current_user.addresses.last
    end


    def checkout_product
      # binding.pry
      amount = @@f_value
      product_price_lists = [] 	
      products = Product.where(id: @cart.map(&:id))
      if @@trans == 1
        payment_gateway = "COD"
        trans_id = 1
      else
        payment_gateway = "Stripe"
        trans_id = @@trans
      end
      addresses = current_user.addresses.last
      # binding.pry
      order = UserOrder.create(user_id: current_user.id,address_id: addresses.id, grand_total: amount,payment_gateway_id: payment_gateway, transaction_id: trans_id)
      if order.save
        products.each do |product|
          order.order_details.create(product_id: product.id, amount:product.price, quantity: product.quantity)
          total = (product.quantity)*(product.price)
          product_price_lists << total
        end
      else
        puts "------------------------#{order.errors.full_messages}-----------------------"
        # UserMailer.send_order_details(current_user,order).deliver
        # UserMailer.send_order_details_admin(current_user,order).deliver
      end
    end
  
  def contact
    @cms = Cm.all
    @cont = ContactU.last
  end

  def contact_us
    @cms = Cm.all
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

  def cod
    @cms = Cm.all
    @@trans = 1
    checkout_product
    @value = @@f_value
    session[:cart] = nil
  end  
    
  def login
    
  end

  def track
    # binding.pry
    order = current_user.user_orders.all
    order_id = params[:user_order_id]
    # binding.pry
    if order.include?(order_id)
      @user_order = UserOrder.find_by(id: params[:user_order_id])
    else
      flash[:notice] = "please enter correct user id "
    end
		
  end  

  def order
    @cms = Cm.all
    @orders = current_user.user_orders.all      #current_user.user_orders
  end  
  
  def product_details
    @cms = Cm.all
    @category = Category.find(params[:id]) 
    @products = @category.products
  end
  
  def success
    @cms = Cm.all
    response = Stripe::Checkout::Session.retrieve(id: params[:session_id])
    # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#{response}"
    @trans_id = response[:payment_intent]
    @@trans = @trans_id
    payable_amt = response[:amount_total]
    @total_amt = payable_amt/100
    amount= payable_amt/100
    @pay_response = current_user.payment_responses.create(transaction_id: response[:payment_intent], amount: amount)
    checkout_product
    @products = Product.all
    session[:cart] = nil
  end

  def shop
    @cms = Cm.all
  end
  
  
  def error404
  end    

  def catprods
    @cms = Cm.all
    @category = Category.all
  end

  private
  def address_params   #used in User_address
    params.require(:address).permit(:address_1,:pincode, :mobile_no, :country, :city, :state)
  end
  # .
  def contact_params
		params.permit(:name,:email,:contact_no,:message)
	end
end
