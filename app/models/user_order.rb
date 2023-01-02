class UserOrder < ApplicationRecord
    belongs_to :user
    has_many :addresses, :dependent => :destroy
    has_many :order_details, :dependent => :destroy
    has_many :products, :through => :order_details, :dependent => :destroy
    # belongs_to :payment_gateway
    enum status: {
        ordered: 0,
        shipped: 1,
        delivered: 2
    }
        
end
