class ProductDetail < ApplicationRecord
    belongs_to :product
    belongs_to :subcat
end
