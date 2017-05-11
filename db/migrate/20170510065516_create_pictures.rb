class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :public_id
      t.belongs_to :supplier, foreign_key: true

      t.timestamps
    end
  end
end
