class AddProductIdToProductDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_details, :product, null: false, foreign_key: true
    add_reference :addresses, :user,null: true, foreign_key: true
    add_reference :user_orders, :address,null: true, foreign_key: true
  end
end
