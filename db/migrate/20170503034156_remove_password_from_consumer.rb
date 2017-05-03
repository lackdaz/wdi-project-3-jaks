class RemovePasswordFromConsumer < ActiveRecord::Migration[5.0]
  def change
    remove_column :consumers, :password, :string
  end
end
