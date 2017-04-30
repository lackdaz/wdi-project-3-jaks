class CreateOrderIcecreams < ActiveRecord::Migration[5.0]
  def change
    create_table :order_icecreams do |t|
      t.string :order_id
      t.string :icecream_id

      t.timestamps
    end
  end
end
