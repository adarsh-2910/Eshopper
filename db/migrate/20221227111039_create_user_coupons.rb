class CreateUserCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :user_coupons do |t|

      t.timestamps
    end
  end
end
