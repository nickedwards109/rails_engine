class Invoice < ApplicationRecord
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
end
