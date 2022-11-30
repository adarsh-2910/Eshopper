class Product < ApplicationRecord
    belongs_to :category
    has_many :product_details
    has_many :subcats, through: :product_details
    has_one_attached :image
end
