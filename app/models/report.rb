class Report < ApplicationRecord
   def sales_report
    UserOrder.all.size
   end 

   def customer_registered
    User.all.size
   end 

   def coupons_used
    UserCouponUsed.all.size
   end 
    
end
