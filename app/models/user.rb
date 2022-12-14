class User < ApplicationRecord
  # include Pay::Billable
  pay_customer stripe_attributes: :stripe_attributes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]
  has_many :addresses
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user_email = auth.info.email.present? ? auth.info.email : "user.#{auth.uid}@gmail.com"
      user.email = user_email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # def self.from_omniauth(access_token)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20] 
  #   end
  # end    
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_oauth2"] && session["devise.google_oauth2_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def admin?
    admin
  end   
         
end
