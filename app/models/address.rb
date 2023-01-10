class Address < ApplicationRecord
    has_many :user_orders
    belongs_to :user
end
