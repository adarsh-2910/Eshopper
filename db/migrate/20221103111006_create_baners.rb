class CreateBaners < ActiveRecord::Migration[7.0]
  def change
    create_table :baners do |t|
      t.string :name
      t.timestamps
    end
  end
end
