class UserCouponUsed < ApplicationRecord
    belongs_to :user
    belongs_to :user_coupon
end