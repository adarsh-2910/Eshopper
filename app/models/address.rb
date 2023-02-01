class Address < ApplicationRecord
    validates :address_1, presence: true
    validates :mobile_no,:presence => true,:numericality => true,:length => { :minimum => 10, :maximum => 12 }
    has_many :user_orders
    belongs_to :user    

end
