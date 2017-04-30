class CreateFlavors < ActiveRecord::Migration[5.0]
  def change
    create_table :flavors do |t|
      t.string :flavor_id
      t.string :flavor_name
      t.string :co_id
      t.string :co_name
      t.integer :flavor_price

      t.timestamps
    end
  end
end
