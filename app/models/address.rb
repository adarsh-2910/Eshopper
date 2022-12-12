class Address < ApplicationRecord
    belongs_to :user_order, optional: true
    belongs_to :user
end
