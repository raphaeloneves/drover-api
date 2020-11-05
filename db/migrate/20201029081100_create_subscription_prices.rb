class CreateSubscriptionPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_prices do |t|
      t.decimal :price, null: false
      t.integer :car_id, null: false

      t.timestamps
    end
  end
end
