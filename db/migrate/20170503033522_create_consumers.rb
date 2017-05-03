class CreateConsumers < ActiveRecord::Migration[5.0]
  def change
    create_table :consumers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password_digest
      t.integer :contact

      t.timestamps
    end
  end
end
