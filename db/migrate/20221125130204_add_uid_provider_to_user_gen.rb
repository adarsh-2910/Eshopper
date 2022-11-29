class AddUidProviderToUserGen < ActiveRecord::Migration[7.0]
  def change
    add_column :user_gens, :uid, :string
    add_column :user_gens, :provider, :string
  end
end
