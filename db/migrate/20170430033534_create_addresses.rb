class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :address_id
      t.string :name
      t.string :custid
      t.float :locx
      t.float :locy
      t.timestamps
    end
  end
end
