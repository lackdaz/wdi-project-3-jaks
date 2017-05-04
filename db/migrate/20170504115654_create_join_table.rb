class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :orders, :flavours do |t|
      # t.index [:order_id, :flavour_id]
      # t.index [:flavour_id, :order_id]
    end
  end
end
