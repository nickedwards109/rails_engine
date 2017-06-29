class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_case_insensitive(item_params)
    if item_params[:name]
      Item.find_by("name ILIKE ?", item_params[:name])
    elsif item_params[:description]
      Item.find_by("description ILIKE ?", item_params[:description])
    else
      Item.find_by(item_params)
    end
  end

  def self.find_all_case_insensitive(item_params)
    if item_params[:name]
      Item.where("name ILIKE ?", item_params[:name])
    elsif item_params[:description]
      Item.where("description ILIKE ?", item_params[:description])
    else
      Item.where(item_params)
    end
  end

  def self.most_items(quantity)
    joins(invoices: :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order("sum(quantity) DESC").limit(quantity)
  end

  def self.most_revenue(quantity)
    joins(invoices: [:transactions])
    .where(transactions: {result: "success"})
    .group(:id).order("sum(invoice_items.quantity * cast(invoice_items.unit_price as integer)) DESC")
    .limit(quantity)
  end

  def best_day
    invoices.joins(:invoice_items)
    .group('invoices.id, invoices.created_at')
    .order('sum(invoice_items.quantity) DESC')
    .first
    .created_at
  end
end
