class Merchant < ApplicationRecord
  include FormattingHelper
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices


  def total_revenue(date=nil)
    if date
      total_revenue_scoped_to(date)
    else
      total_revenue_across_all_dates
    end
  end

  def total_revenue_scoped_to(date)
    revenue = self.invoices
    .joins(:transactions)
    .merge(Transaction.successful)
    .joins(:invoice_items)
    .where("invoices.created_at = ?", date)
    .sum('CAST(invoice_items.unit_price as float) * invoice_items.quantity')

    formatted_revenue = format_to_currency(revenue)
    {revenue: formatted_revenue}
  end

  def total_revenue_across_all_dates
    revenue = self.invoices
    .joins(:transactions)
    .merge(Transaction.successful)
    .joins(:invoice_items)
    .sum('CAST(invoice_items.unit_price as float) * invoice_items.quantity')

    formatted_revenue = format_to_currency(revenue)
    {revenue: formatted_revenue}
  end

  def self.top_ranked_by_revenue(quantity)
    top_merchants = Merchant.find_by_sql("
    SELECT merchants.*,
    SUM(CAST(invoice_items.unit_price AS float) * invoice_items.quantity)
    AS revenue
    FROM merchants
    INNER JOIN invoices ON invoices.merchant_id = merchants.id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id
    WHERE transactions.result = 'success'
    GROUP BY merchants.id
    ORDER BY revenue DESC
    LIMIT #{quantity} ;")
  end

  def self.top_ranked_by_items_sold(quantity)
    top_merchants = Merchant.find_by_sql("
    SELECT merchants.*,
    SUM(invoice_items.quantity) AS quantity
    FROM merchants
    INNER JOIN invoices ON invoices.merchant_id = merchants.id
    INNER JOIN transactions ON transactions.invoice_id = invoices.id
    INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id
    WHERE transactions.result = 'success'
    GROUP BY merchants.id
    ORDER BY quantity DESC
    LIMIT #{quantity} ;")
  end
end
