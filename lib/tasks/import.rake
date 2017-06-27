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
  end
end