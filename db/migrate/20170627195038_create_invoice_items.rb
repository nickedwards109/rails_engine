class CreateInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_items do |t|
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true
      t.integer :quantity
      t.string :unit_price

      t.timestamps
    end
  end
end
