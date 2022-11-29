class AddSubcatNameToSubcat < ActiveRecord::Migration[7.0]
  def change
    add_column :subcats, :subcat_name, :string
  end
end
