class Product < ApplicationRecord
    belongs_to :category 
    has_many :product_images, dependent: :destroy
    has_one_attached :image
end
