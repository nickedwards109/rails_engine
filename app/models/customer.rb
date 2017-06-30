class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.favorite_customer(merchant_id)
    favorite_customer = Customer.find_by_sql("
    SELECT customers.*,
    COUNT(customers.id) AS successful_transactions_count
    FROM customers
    INNER JOIN invoices ON invoices.customer_id = customers.id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    INNER JOIN merchants ON merchants.id = invoices.merchant_id
    WHERE transactions.result = 'success'
    AND merchants.id = #{merchant_id}
    GROUP BY customers.id
    ORDER BY successful_transactions_count DESC
    LIMIT 1
    ;").first
  end

  def self.unpaid_invoices(merchant_id)
    customers_with_unpaid_invoices = Customer.find_by_sql("
    SELECT customers.* FROM customers
    INNER JOIN invoices ON invoices.customer_id = customers.id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    INNER JOIN merchants ON merchants.id = invoices.merchant_id
    WHERE transactions.result = 'failed'
    AND merchants.id = #{merchant_id}
    EXCEPT
    SELECT customers.* FROM customers
    INNER JOIN invoices ON invoices.customer_id = customers.id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    INNER JOIN merchants ON merchants.id = invoices.merchant_id
    WHERE transactions.result = 'success'
    AND merchants.id = #{merchant_id}
    ;")

  def favorite_merchant
    merchants.joins(:transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order('count(transactions) DESC')
    .first
  end

  def self.unpaid_invoices(merchant_id)
    customers_with_unpaid_invoices = Customer.find_by_sql("
    SELECT customers.* FROM customers
    INNER JOIN invoices ON invoices.customer_id = customers.id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    INNER JOIN merchants ON merchants.id = invoices.merchant_id
    WHERE transactions.result = 'failed'
    AND merchants.id = #{merchant_id}
    EXCEPT
    SELECT customers.* FROM customers
    INNER JOIN invoices ON invoices.customer_id = customers.id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    INNER JOIN merchants ON merchants.id = invoices.merchant_id
    WHERE transactions.result = 'success'
    AND merchants.id = #{merchant_id}
    ;")
  end
end
