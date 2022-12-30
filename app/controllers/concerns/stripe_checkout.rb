module StripeCheckout

    def checkout_session(value)
    product=Stripe::Product.create({name: 'Order 1'})
    Stripe::Price.create({
    unit_amount: value,
    # product: {{product.id}},
    currency: 'usd',
    product: product.id,
    })
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [
        price_data: {
        product: product.id,
        unit_amount: value,
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
end          