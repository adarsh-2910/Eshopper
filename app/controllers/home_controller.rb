class HomeController < ApplicationController
  require "MailchimpMarketing"
  skip_before_action :authenticate_user!
  def index
  end

  def mailchimp
    # binding.pry    
    mailchimp = MailchimpMarketing::Client.new
    mailchimp.set_config({
      :api_key => "c8653bb20730e6d2db806ec1554c0a27",
      :server => "us13"                  #datacenter dc
    })
    list_id = "cdd89c9809"               #uniqueid/audienceid/list_id
    # binding.pry
    response = mailchimp.lists.add_list_member list_id, {
      email_address: params[:email],
      status: "subscribed",
    }
  flash[:message] = "Subscribed"
  end
end
