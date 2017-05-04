class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :consumer, foreign_key: true
      t.references :delivery_address, foreign_key: true

      t.timestamps
    end
  end
end
