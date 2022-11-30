class AddSubcatIdToProductDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_details, :subcat, null: false, foreign_key: true
  end
end
