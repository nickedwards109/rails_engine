require 'csv'

namespace :csv do
  task :import => :environment do
    CSV.foreach("data/merchants.csv", headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Merchant.create!([
                        name: row["name"],
                        created_at: row["created_at"],
                        updated_at: row["updated_at"]
                      ])
    end

    CSV.foreach("data/customers.csv", headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Customer.create!([
                        first_name: row["first_name"],
                        last_name: row["last_name"],
                        created_at: row["created_at"],
                        updated_at: row["updated_at"]
                      ])
    end

    CSV.foreach("data/transctions.csv", headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
      Transaction.create!([
                          invoice_id: row["invoice_id"],
                          credit_card_number: row["credit_card_number"],
                          credit_card_expiration_date: row["credit_card_expiration_date"],
                          created_at: row["created_at"],
                          updated_at: row["updated_at"]
                        ])
    end

  end
end