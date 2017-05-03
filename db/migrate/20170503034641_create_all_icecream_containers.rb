class CreateAllIcecreamContainers < ActiveRecord::Migration[5.0]
  def change
    create_table :all_icecream_containers do |t|
      t.string :name
      t.float :price
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
