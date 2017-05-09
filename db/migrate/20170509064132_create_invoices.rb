class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.references :user, foreign_key: true
      t.references :delivery_address, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
