class AddContactToSupplier < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :contact, :integer
  end
end
