class AddColumnsToCms < ActiveRecord::Migration[7.0]
  def change
    add_column :cms, :title, :varchar, :limit => 255
    add_column :cms, :meta_title, :text
    add_column :cms, :meta_description, :text
    add_column :cms, :meta_keywords, :text
    add_column :cms, :created_by, :integer
    add_column :cms, :create_date, :date
    add_column :cms, :modify_by, :integer
    add_column :cms, :modified_date, :date

  end
end
