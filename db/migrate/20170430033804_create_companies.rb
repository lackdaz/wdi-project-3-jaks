class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :co_id
      t.string :stall
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.integer :contact

      t.timestamps
    end
  end
end
