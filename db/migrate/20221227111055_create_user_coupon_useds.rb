class CreateUserCouponUseds < ActiveRecord::Migration[7.0]
  def change
    create_table :user_coupon_useds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_coupon, null: false, foreign_key: true
      t.timestamps
    end
  end
end
