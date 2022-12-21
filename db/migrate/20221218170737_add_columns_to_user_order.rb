class AddColumnsToUserOrder < ActiveRecord::Migration[7.0]
  def change
      add_column :user_orders, :AWB_NO, :varchar, :limit => 100
      add_column :user_orders, :payment_gateway_id, :varchar, :limit => 100
      add_column :user_orders, :transaction_id, :integer
      add_column :user_orders, :created_date, :date
      add_column :user_orders, :grand_total, :decimal, precision: 12, scale: 2
      add_column :user_orders, :shipping_charges, :decimal, precision: 12, scale: 2
  end
end