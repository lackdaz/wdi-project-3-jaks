class CreateDeliveryAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_addresses do |t|
      t.references :consumer, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
