class AddColumnToSupplier < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :address, :string
    add_column :suppliers, :postal, :integer
    add_column :suppliers, :website, :string
  end
end
