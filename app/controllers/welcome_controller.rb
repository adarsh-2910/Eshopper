class WelcomeController < ApplicationController
@@f_value = 0
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
    # binding.pry
    product = Product.all
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
    
    user_c = UserCoupon.find_by(coupon_code: params[:coupon_code])
      if params[:coupon_code].nil?
        @f_value = @final_value
        @@f_value = @final_value
      elsif user_c.nil?
        flash.now[:notice] = "Coupon invalid"
      elsif @user.user_coupons.include?(user_c)
        flash.now[:notice] = "already applied!"
      else
        user_c.no_of_uses += 1
        @user.user_coupons << user_c
        @f_value = @final_value - (@final_value*(user_c.percent_off)/100)
        @@f_value = @f_value
        flash.now[:notice] = "Coupon applied successfully!"
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
      
      order = UserOrder.create(user_id: current_user.id,address_id: addresses.id, grand_total: amount,payment_gateway_id: payment_gateway, transaction_id: trans_id )
      if order.save
        products.each do |product|
          order.order_details.create(product_id: product.id, amount:product.price, quantity: product.quantity)
          total = (product.quantity)*(product.price)
          product_price_lists << total
        end
      else
        puts "------------------------#{order.errors.full_messages}-----------------------"
        UserMailer.send_order_details(current_user,order).deliver
        UserMailer.send_order_details_admin(current_user,order).deliver
      end
    end
  
  def contact
    # binding.pry
    @contact=ContactU.new
    @cont = current_user.contact_us.last
  end

  def contact_us
    # binding.pry
    @user= current_user
    @contact= @user.contact_us.new(contact_params)
    @cont = ContactU.last
    if @contact.save
      flash.now[:notice] = "Customer contacted !"
      redirect_to welcome_contact_path
    else
      flash.now[:error] = "failed"
      render:contact
    end
  end

  def cod
    @@trans = 1
    checkout_product
    @value = @@f_value
    session[:cart] = nil
  end  
    
  def login
  end

  def track
    order = current_user.user_orders.all
    id = params[:user_order_id].to_i
    # binding.pry    
		if (order.ids).include?(id) 
      @user_order = UserOrder.find_by(id: id)
    elsif id != 0 && (order.ids).include?(id) == false   #if we convert nil to integer we get 0 so wrote 0 instead of nil
      flash[:alert] = "incorrect order id"
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
    params.permit(:address_1,:pincode, :mobile_no, :country, :city, :state)
  end
  #require(:address)
  def contact_params
		params.require(:contact_u).permit(:name,:email,:contact_no,:message)
	end
end
