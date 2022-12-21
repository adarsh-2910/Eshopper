class AddColumnsToPaymentGateway < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_gateways, :name, :varchar, :limit => 100
    add_column :payment_gateways, :updated_date, :date
    add_column :payment_gateways, :modify_by, :integer
    add_column :payment_gateways, :modify_date, :date

  end
end
