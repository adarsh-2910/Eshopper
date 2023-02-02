class HomeController < ApplicationController
  require "MailchimpMarketing"
  skip_before_action :authenticate_user!
  def index
    @feature_products = Product.all rescue nil 
    @category = Category.where(parent_id: nil)  
    @baner = Baner.all
    @cms = Cm.all
  end

  def mailchimp
    mailchimp = MailchimpMarketing::Client.new()
    mailchimp.set_config({
      :api_key => "c8653bb20730e6d2db806ec1554c0a27",
      :server => "us13"                  
    })
    list_id = "cdd89c9809"               
    response = mailchimp.lists.add_list_member list_id, {
      email_address: params[:email],
      status: "subscribed",
      merge_fields:{
        FNAME: params[:fname],
        LNAME: params[:lname],
        ADDRESS: {
          addr1: params[:addr1],
          city: params[:city],
          state: params[:state],
          zip: params[:zip],
        },
      },
    }
  # flash.now[:notice] = "Subscribed"
  # rescue MailchimpMarketing::ApiError => e
  # flash[:notice] = "user already exists"
  # puts "Error: #{e}"

  end
end
