class AddColumsToUserOrderDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :order_details, :product, null: true, foreign_key: true
    add_reference :order_details, :user_order, null:true, foreign_key: true
    add_reference :user_orders, :user, null:true, foreign_key:true 
  end
end
