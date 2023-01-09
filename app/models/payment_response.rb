class PaymentResponse < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
