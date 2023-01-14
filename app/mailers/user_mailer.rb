class UserMailer < ApplicationMailer
  default from: 'Eshopper@noreply'

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
    # mail(to: @user.email, subject:'contact form updated!')
  end

  def contact_mail(user)
    @user = user
    mail(to: 'adarsh.shrivastav001@gmail.com',subject:'User contact saved successfully')
  end

  def send_order_details(user,order)
    @order = order
    @user = user
    mail(to: @user.email, subject:'Order placed')
  end

  def send_order_details_admin(user,order)
    @user = user
    @order = order
    mail(to: 'adarsh.shrivastav001@gmail.com',subject:'Order details of user')
  end  

  def status_update(user,status)
    @status = status
    @user = user
    mail(to: user.email, subject: "Your order status has been changed")
  end  

  def sendmail
    @consolidated = UserOrder.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
      count = []
      @consolidated.each do |cd|
          a = cd.id
          count << a
      end
      @asd = count
      
      mail(to: "adarsh.shrivastav001@gmail.com", subject: 'consolidated mail for orders')
  end   
  
  def wishlistmail_admin
    @wishlist = UserWishlist.all
    @user = User.find_by(admin: true)
    mail(to: @user.email, subject: 'users wishlist weekly')
  end  
end