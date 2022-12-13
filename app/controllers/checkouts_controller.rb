class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def show
      current_user.set_payment_processor :stripe #this defines that the payment processor is stripe.
      # current_user.customer

      @checkout_session = current_user.payment_processor.checkout(
        mode: "payment",
        line_items: "price_1MEVqvSC7PKc8iLeJCcCDX8P" #the products that we want user to purchase
      )
    end
end        