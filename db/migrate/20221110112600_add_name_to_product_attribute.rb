class AddNameToProductAttribute < ActiveRecord::Migration[7.0]
  def change
    add_column :product_attributes, :name, :varchar, :limit => 45
    add_column :product_attributes, :created_by, :integer
    add_column :product_attributes, :create_date, :date
    add_column :product_attributes, :modify_by, :integer
    add_column :product_attributes, :modified_date, :date
  end
end
