class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :in_a
      t.integer :order_price
      t.string :dbox_id
      t.string :address_id

      t.timestamps
    end
  end
end
