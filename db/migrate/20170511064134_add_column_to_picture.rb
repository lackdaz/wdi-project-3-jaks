class AddColumnToPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :profilepic, :boolean
  end
end
