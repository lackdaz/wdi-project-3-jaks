class CreateDeliveryboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveryboxes do |t|
      t.string :locX
      t.string :locY
      t.string :temperature
      t.references :transaction, foreign_key: true
      t.references :deliveryman, foreign_key: true

      t.timestamps
    end
  end
end
