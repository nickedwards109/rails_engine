require 'csv'

namespace :csv do
  task :import => :environment do

    def format_unit_price(unit_price)
      digits = unit_price.split("")
      cents = []
      cents << digits.pop
      cents << digits.pop
      digits << "."
      digits << cents.pop
      digits << cents.pop
      digits.join
    end

    CSV.foreach('data/merchants.csv', headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Merchant.create!([
                        name: row["name"],
                        created_at: row["created_at"],
                        updated_at: row["updated_at"]
                        ])
			end

		CSV.foreach('data/items.csv', headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Item.create!([
                    name: row["name"],
                    description: row["description"],
                    unit_price: format_unit_price(row["unit_price"]),
                    merchant_id: row["merchant_id"],
                    created_at: row["created_at"],
                    updated_at: row["updated_at"]
                  ])
    end

    CSV.foreach('data/customers.csv', headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Customer.create!([
                        first_name: row["first_name"],
                        last_name: row["last_name"],
                        created_at: row["created_at"],
                        updated_at: row["updated_at"]
                      ])
      end

    CSV.foreach('data/invoices.csv', headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Invoice.create!([
                        merchant_id: row["merchant_id"],
                        customer_id: row["customer_id"],
                        status: row["status"],
                        created_at: row["created_at"],
                        updated_at: row["updated_at"]
                       ])
    end

		CSV.foreach('data/transactions.csv', headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Transaction.create!([
                            credit_card_number: row["credit_card_number"],
                            credit_card_expiration_date: row["credit_card_expiration_date"],
                            result: row["result"],
                            created_at: row["created_at"],
                            updated_at: row["updated_at"],
                            invoice_id: row["invoice_id"]
                          ])
		end

		CSV.foreach('data/invoice_items.csv', headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      InvoiceItem.create!([
                            item_id: row["item_id"],
                            invoice_id: row["invoice_id"],
                            quantity: row["quantity"],
													  unit_price: format_unit_price(row["unit_price"]),
                            created_at: row["created_at"],
                            updated_at: row["updated_at"],
													])
		end
  end
end
