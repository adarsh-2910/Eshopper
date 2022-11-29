class AddColumsToUserGen < ActiveRecord::Migration[7.0]
  def change
    add_column :user_gens, :first_name, :varchar, :limit => 45
    add_column :user_gens, :last_name, :varchar, :limit => 45
    # add_column :user_gens, :email, :varchar, :limit => 45
    add_column :user_gens, :password, :varchar, :limit => 45
    add_column :user_gens, :created_date, :date
    add_column :user_gens, :fb_token, :varchar, :limit => 100
    add_column :user_gens, :twitter_token, :varchar, :limit => 100
    add_column :user_gens, :google_token, :varchar, :limit => 100
  end
end
