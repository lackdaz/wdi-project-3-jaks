class CreateStalls < ActiveRecord::Migration[5.0]
  def change
    create_table :stalls do |t|
      t.string :stall_id
      t.string :co_name
      t.string :email
      t.string :password
      t.string :address
      t.float :locx
      t.float :locy
      t.integer :contact
      t.string :owner_firstname
      t.string :owner_lastname

      t.timestamps
    end
  end
end
