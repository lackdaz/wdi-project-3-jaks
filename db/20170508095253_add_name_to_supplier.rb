class AddNameToSupplier < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :name, :string
  end
end
