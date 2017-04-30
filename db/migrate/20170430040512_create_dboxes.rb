class CreateDboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :dboxes do |t|
      t.string :id
      t.string :dman_firstname
      t.string :dman_lastname
      t.string :email
      t.string :password
      t.integer :contact
      t.double :locx
      t.string :precision
      t.double :locy
      t.string :precision
      t.integer :temp

      t.timestamps
    end
  end
end
