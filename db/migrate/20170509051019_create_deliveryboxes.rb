class CreateDeliveryboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveryboxes do |t|
      t.string :locX
      t.string :locY
      t.string :temperature
      t.references :deliveryman, foreign_key: true,optional: true
      t.references :invoice, foreign_key: true,optional: true

      t.timestamps
    end
  end
end
