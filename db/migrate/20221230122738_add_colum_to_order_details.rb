class AddColumToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :user_orders, :status, :integer, default: 0
  end
end
