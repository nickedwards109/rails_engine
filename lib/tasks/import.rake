require 'csv'

namespace :csv do
  task :import => :environment do
    CSV.foreach("data/items.csv", headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Item.create!([
                    name: row["name"],
                    description: row["description"],
                    unit_price: row["unit_price"],
                    merchant_id: row["merchant_id"],
                    created_at: row["created_at"],
                    updated_at: row["updated_at"]
                    ])
    end
    CSV.foreach("data/invoices.csv", headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Invoice.create!([
                       status: row["shipped"],
                       # not importing foreign keys until we set up relationships
                       # customer_id: row["customer_id"],
                       # merchant_id: row["merchant_id"],
                       ])
    end
    CSV.foreach("data/invoice_items.csv", headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      InvoiceItem.create!([
                       item_id: row["item_id"],
                       invoice_id: row["invoice_id"],
                       quantity: row["quantity"],
                       unit_price: row["unit_price"]
                       ])
    end
    CSV.foreach("data/merchants.csv", headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Merchant.create!([
                        name: row["name"],
                        created_at: row["created_at"],
                        updated_at: row["updated_at"]
                      ])
    end
  end
end
