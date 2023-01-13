class ContactU < ApplicationRecord
    after_update :contact_update_mail
    after_save :contact_mail
    validates :name , presence: {message: "Name is required"}

    def contact_update_mail
        UserMailer.contact_update_mail(self).deliver
    end

    def contact_mail
    	UserMailer.contact_mail(self).deliver
  	end 
end
