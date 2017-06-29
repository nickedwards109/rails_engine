class Merchant < ApplicationRecord
  include FormattingHelper
  has_many :items
  has_many :invoices

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
end
