class CreateContainers < ActiveRecord::Migration[5.0]
  def change
    create_table :containers do |t|
      t.string :name
      t.float :price
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
