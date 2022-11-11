class AddCategoryIdToSubcat < ActiveRecord::Migration[7.0]
  def change
    add_column :subcats, :category_id, :string
  end
end
