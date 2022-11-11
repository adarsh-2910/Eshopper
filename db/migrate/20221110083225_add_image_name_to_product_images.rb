class AddImageNameToProductImages < ActiveRecord::Migration[7.0]
  def change
    add_column :product_images, :productname, :varchar, :limit => 100
    add_column :product_images, :created_by, :integer
    add_column :product_images, :create_date, :date
  end
end
