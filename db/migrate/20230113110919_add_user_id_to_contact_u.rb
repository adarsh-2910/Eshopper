class AddUserIdToContactU < ActiveRecord::Migration[7.0]
  def change
    add_reference :contact_us, :user, null:false, foreign_key:true
  end
end
