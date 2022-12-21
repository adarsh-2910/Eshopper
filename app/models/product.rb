class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, :through=>:product_categories,:dependent => :destroy
    has_many :product_details
    has_one_attached :image
    belongs_to :user_wishlists
    # belongs_to :user_wishlist
end
