class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_send(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Eshoppers!')
  end

  def mail_admin(user)
    @user = user
    mail(to: "adarsh.shrivastav001@gmail.com", subject: 'Copy of new registered user')
  end  

  # def send_order_details()

  # end  

  def contact_update_mail(contact_info)
    @contact_info = contact_info
    @user = User.find_by(email: contact_info.email)
    mail(to: @user.email,subject:'contact form updated!')
  end

  def contact_mail(user)
    @user = user
    mail(to: 'adarsh.shrivastav001@gmail.com',subject:'User contact saved successfully')
  end

  def send_order_details(order_info)
    binding.pry
    @info = order_info

    mail(to: 'adarsh.shrivastav001@gmail.com',subject:'Order placed')
    
  end

end