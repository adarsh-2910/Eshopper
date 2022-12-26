class CreatePaymentResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_responses do |t|
      t.column :transaction_id, :string
      
      t.column :amount, :integer
      t.column :currency, :string, :default => "USD"
      t.references :user, null: false, foreign_key: true    #to access current_user.id
      # t.references :user_order, null: true, foreign_key: true
      # t.column :pay_response, :text
      t.timestamps
    end
  end
end
