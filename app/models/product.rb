class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, :through=>:product_categories,:dependent => :destroy
    has_many :product_details
    has_one_attached :image
    has_many :user_wishlists
	has_many :users, through: :user_wishlists
end
