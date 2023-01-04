class OrderDetail < ApplicationRecord
    belongs_to :user_order,:dependent => :destroy
    belongs_to :product, :dependent => :destroy
    after_save :send_order_details

    def send_order_details
      UserMailer.send_order_details(self).deliver
    end
end
