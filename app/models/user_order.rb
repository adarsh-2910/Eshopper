class UserOrder < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_details, dependent: :destroy
  has_many :products, :through => :order_details
  after_update :status_update
  enum status: {
    ordered: 0,
    shipped: 1,
    delivered: 2
  }
    
  def status_update
    # binding.pry
    if status == "delivered" or status == "shipped"
      UserMailer.status_update(user,status).deliver
    end
  end  
  
end
