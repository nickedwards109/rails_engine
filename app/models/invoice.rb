class Invoice < ApplicationRecord
  extend FormattingHelper
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.find_case_insensitive(invoice_params)
    if invoice_params[:status]
      Invoice.find_by("status ILIKE ?", invoice_params[:status])
    else
      Invoice.find_by(invoice_params)
    end
  end

  def self.find_all_case_insensitive(invoice_params)
    if invoice_params[:status]
      Invoice.where("status ILIKE ?", invoice_params[:status])
    else
      Invoice.where(invoice_params)
    end
  end

  def self.total_revenue_scoped_to(date)
    revenue = self.joins(:transactions)
    .merge(Transaction.successful)
    .joins(:invoice_items)
    .where("invoices.created_at = ?", date)
    .sum('CAST(invoice_items.unit_price as float) * invoice_items.quantity')

    formatted_revenue = format_to_currency(revenue)
    {total_revenue: formatted_revenue}
  end
end
