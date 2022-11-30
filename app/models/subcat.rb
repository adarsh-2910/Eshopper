class Subcat < ApplicationRecord
    belongs_to :category
    has_many :product_details
    has_many :products, through: :product_details

end
