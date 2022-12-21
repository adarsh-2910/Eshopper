class PaymentGateway < ApplicationRecord
    has_many :user_orders
end
