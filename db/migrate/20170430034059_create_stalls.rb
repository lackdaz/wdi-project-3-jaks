class CreateStalls < ActiveRecord::Migration[5.0]
  def change
    create_table :stalls do |t|
      t.string :id
      t.string :co_name
      t.string :email
      t.string :password
      t.string :address
      t.double :locx
      t.string :precision
      t.double :locy
      t.string :precision
      t.integer :contact
      t.stringowner_lastname :owner_firstname

      t.timestamps
    end
  end
end
