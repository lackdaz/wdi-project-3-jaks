class CreateIcecreams < ActiveRecord::Migration[5.0]
  def change
    create_table :icecreams do |t|
      t.string :id
      t.string :stall_id
      t.string :flavor_id

      t.timestamps
    end
  end
end
