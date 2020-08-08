class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer "end_user_id"
      t.integer "preparation_status"
      t.integer "total_price"
      t.string "recipient_name"
      t.string "zip_code"
      t.string "address"
      t.integer "payment_method"
      t.integer "shipping_fee"

      t.timestamps
    end
  end
end
