class AddCurrencyToOrderDetail < ActiveRecord::Migration[7.0]
  def change
    add_column :user_orders, :currency, :string, default: "USD"
  end
end
