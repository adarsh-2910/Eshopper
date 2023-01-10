class AddColumsToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :address_1, :string
    add_column :addresses, :state, :varchar, :limit => 45
    add_column :addresses, :country, :varchar, :limit => 45
    add_column :addresses, :pincode, :integer
    add_column :addresses, :mobile_no, :string
  end
end
