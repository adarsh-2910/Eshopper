class User < ApplicationRecord
  # include Pay::Billable
  pay_customer stripe_attributes: :stripe_attributes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]
  has_many :addresses
  has_many :user_wishlists  
  has_many :products, through: :user_wishlists
  has_many :payment_responses, dependent: :destroy  
  has_many :user_orders, :dependent => :destroy    
  ##coupon
  has_many :user_coupon_useds, :dependent => :destroy
  has_many :user_coupons, through: :user_coupon_useds, :dependent => :destroy

  has_many :contact_us
  #email
  after_create :welcome_send
  #validations
  validates :first_name, format: { with: /\A[a-zA-Z]+\z/,message: "only letters are allowed" }
  validates :last_name, format: { with: /\A[a-zA-Z]+\z/,message: "only letters are allowed" }
  validates :email, presence: { message: 'email field cannot be empty' }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user| #created record only if table is empty
      user_email = auth.info.email.present? ? auth.info.email : "user.#{auth.uid}@gmail.com"
      user.email = user_email
      user.password = Devise.friendly_token[0, 20]
    end
  end 

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_oauth2"] && session["devise.google_oauth2_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end 

  def welcome_send
    UserMailer.welcome_send(self).deliver
    UserMailer.mail_admin(self).deliver
  end  

end
