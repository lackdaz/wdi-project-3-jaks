class CreateAllFlavours < ActiveRecord::Migration[5.0]
  def change
    create_table :all_flavours do |t|
      t.string :name
      t.integer :price
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
