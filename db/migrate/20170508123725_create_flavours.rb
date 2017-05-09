class CreateFlavours < ActiveRecord::Migration[5.0]
  def change
    create_table :flavours do |t|
      t.string :name
      t.float :price
      t.string :image
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
