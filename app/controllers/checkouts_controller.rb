class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def stripe
    cart_amount                      #method call
    
    product=Stripe::Product.create({name: 'Order 1'})
    Stripe::Price.create({
    unit_amount: @value*(100),
    # product: {{product.id}},
    currency: 'usd',
    product: product.id,
    })
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [
        price_data: {
        product: product.id,
        unit_amount: @value*(100),
        currency: 'usd'
      },
      quantity: 1,
      ],
      mode: 'payment',
      # success_url: shop_success_path(@session.id),
      success_url: 'http://localhost:3000/welcome/success?true&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,
      })
      
    end

    def cart_amount
      product_price_lists = [] 
      @cart.each do |product| 
      temp = (product.quantity)*(product.price)
      product_price_lists << temp
      end
      @total_price = product_price_lists.inject {|sum,price| sum + price}
      @value = @total_price.to_i
    end  

    def cod
      cart_amount
    end  

    def index
    end  

  
end 



