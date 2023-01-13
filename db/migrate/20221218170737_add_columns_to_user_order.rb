class AddColumnsToUserOrder < ActiveRecord::Migration[7.0]
  def change
      add_column :user_orders, :payment_gateway_id, :varchar, :limit => 100
      add_column :user_orders, :transaction_id, :string
      add_column :user_orders, :grand_total, :integer
      add_column :user_orders, :shipping_method, :string, default: "Regular shipping" 
  end
end
