class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :id
      t.string :name
      t.string :custid
      t.double :locx
      t.string :precision
      t.double :locy
      t.string :precision

      t.timestamps
    end
  end
end
