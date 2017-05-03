class CreateSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :address
      t.integer :contact
      t.string :email
      t.string :password_digest
      t.string :website

      t.timestamps
    end
  end
end
