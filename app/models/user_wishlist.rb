class UserWishlist < ApplicationRecord
  belongs_to :user
  # has_many :products
	belongs_to :product
end
