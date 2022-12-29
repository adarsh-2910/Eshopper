class UserOrder < ApplicationRecord
    
    has_many :addresses
    belongs_to :payment_gateway
end
