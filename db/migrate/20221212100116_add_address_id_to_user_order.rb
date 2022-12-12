class AddAddressIdToUserOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_orders, :address, null: true, foreign_key: true
  end
end
