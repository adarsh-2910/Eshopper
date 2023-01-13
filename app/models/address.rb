class Address < ApplicationRecord
    has_many :user_orders
    belongs_to :user    

    # validates :city , presence: {message: "city field cannot be empty"}, format: { with: /\A[a-zA-Z]+\z/,message: "only letters are allowed" }
    # validates :state, presence: {message: "state field cannot be empty"}, format: { with: /\A[a-zA-Z]+\z/,message: "only letters are allowed" }
    # validates :country, presence: {message: "country field cannot be empty"}, format: { with: /\A[a-zA-Z]+\z/,message: "only letters are allowed" }
    # validates :address_1, presence: {message: "address field cannot be empty"}
    # validates :pincode, presence: {message: "pincode is required"}, format: { with: /\Ad{5}\z/, message: "only letters are allowed" }
    # validates :mobile_no, presence: {message: "mobile no. is required"}, format: { with: /\Ad{5}\z/, message: "only letters are allowed" }

end
