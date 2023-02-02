class ContactController < ApplicationController
    def index
        @contact=ContactU.new
        @cont = current_user.contact_us.last
    end
    
    def create
        @user= current_user
        @contact= @user.contact_us.new(contact_params)
        @cont = ContactU.last
        if @contact.save
        redirect_to welcome_contact_path, notice: "Contacted to Eshopper's admin"
        else
        flash.now[:error] = "failed"
        render:contact
        end
        end    
end
