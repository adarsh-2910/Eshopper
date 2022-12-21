class AddAddressIdToUserOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_orders, :address, null: true, foreign_key: true
    # add_column :user_orders, :payment_gateway_id, :integer

    # add_foreign_key :user_orders, :addresses, column: "address_1"
  end
end
