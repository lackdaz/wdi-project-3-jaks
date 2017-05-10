class CreateDeliveryboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveryboxes do |t|
      t.string :lat
      t.string :lng
      t.string :temp
      t.references :deliveryman, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
