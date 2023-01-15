class ContactU < ApplicationRecord
    after_update :contact_update_mail
    after_save :contact_mail
    validates :name, format: { with: /\A[a-zA-Z]+\z/,message: "only letters are allowed" }
    validates :email , presence: true    
    validates :contact_no, length: {is: 10, message: "should be 10 digits"}
    belongs_to :user

    def contact_update_mail
        UserMailer.contact_update_mail(self).deliver
    end 

    def contact_mail
    	UserMailer.contact_mail(self).deliver
  	end 
end
