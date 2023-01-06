class CreateCms < ActiveRecord::Migration[7.0]
  def change
    create_table :cms do |t|

      t.timestamps
    end
  end
end
