class CreateDboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :dboxes do |t|
      t.string :dbox_id
      t.string :dman_firstname
      t.string :dman_lastname
      t.string :email
      t.string :password
      t.integer :contact
      t.float :locx
      t.float :locy
      t.integer :temp

      t.timestamps
    end
  end
end
