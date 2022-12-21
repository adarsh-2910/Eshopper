class CreatePaymentGateways < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_gateways do |t|

      t.timestamps
    end
  end
end
