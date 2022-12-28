class AddColumsToCoupon < ActiveRecord::Migration[7.0]
  def change
    add_column :user_coupons, :coupon_code, :varchar, :limit => 45
    add_column :user_coupons, :percent_off, :integer 
    add_column :user_coupons, :create_by, :integer
    add_column :user_coupons, :created_date, :Date
    add_column :user_coupons, :modify_by, :integer
    add_column :user_coupons, :modify_date, :Date
    add_column :user_coupons, :no_of_uses, :integer
  end
end
