class AddCodeToCoupon < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :code, :varchar, :limit => 45
    add_column :coupons, :percent_off, :decimal, precision: 5, scale: 2
    add_column :coupons, :no_of_uses, :integer
    add_column :coupons, :created_by, :integer
    add_column :coupons, :create_date, :date
    add_column :coupons, :modify_by, :integer
    add_column :coupons, :modified_date, :date
  end
end
