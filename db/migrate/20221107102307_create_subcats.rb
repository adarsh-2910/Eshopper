class CreateSubcats < ActiveRecord::Migration[7.0]
  def change
    create_table :subcats do |t|

      t.timestamps
    end
  end
end
