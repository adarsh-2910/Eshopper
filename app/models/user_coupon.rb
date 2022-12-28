class UserCoupon < ApplicationRecord
    has_many :user_coupon_useds , :dependent => :destroy
    has_many :users, through: :user_coupon_useds
end
