class CreateOrderitems < ActiveRecord::Migration[5.0]
  def change
    create_table :orderitems do |t|
      t.references :user, foreign_key: true
      t.references :supplier, foreign_key: true
      t.references :flavour, foreign_key: true
      t.references :container, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
