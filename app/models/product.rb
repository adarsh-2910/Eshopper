class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, :through=>:product_categories,:dependent => :destroy
    has_one_attached :image
    has_many :user_wishlists
	has_many :users, through: :user_wishlists
    has_many :order_details, :dependent => :destroy
    has_many :user_orders, through: :order_details, :dependent => :destroy
    validates :quantity, numericality: { greater_than_or_equal_to: 1 , message: "quantity cannot be less than 1"}
end
