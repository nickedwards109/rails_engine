class Merchant < ApplicationRecord
  include FormattingHelper
  has_many :items
  has_many :invoices

  def total_revenue
    revenue = self.invoices
    .joins(:transactions)
    .merge(Transaction.successful)
    .joins(:invoice_items)
    .sum('CAST(invoice_items.unit_price as float) * invoice_items.quantity')

    formatted_revenue = format_to_currency(revenue)
    {revenue: formatted_revenue}
  end
end
