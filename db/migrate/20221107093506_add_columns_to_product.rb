class AddColumnsToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :name, :varchar, :limit => 100
    add_column :products, :sku, :varchar, :limit => 100
    add_column :products, :short_description, :varchar, :limit => 100
    add_column :products, :long_description, :text
    add_column :products, :price, :integer
    add_column :products, :special_price_from, :date
    add_column :products, :special_price_to, :date
    # add_column :products, :status, :enum
    add_column :products, :quantity, :integer
    add_column :products, :meta_title, :varchar, :limit => 100
    add_column :products, :meta_description, :text
    add_column :products, :meta_keywords, :text
    # add_column :products, :status, :enum
    add_column :products, :created_by, :integer
    add_column :products, :create_date, :date
  end
end


