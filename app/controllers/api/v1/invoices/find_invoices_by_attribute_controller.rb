class Api::V1::Invoices::FindInvoicesByAttributeController < ApplicationController
  def show
    render json: Invoice.find_case_insensitive(invoice_params)
  end

  def index
    render json: Invoice.find_all_case_insensitive(invoice_params)
  end

  private
  def invoice_params
    params.permit(:id, :status)
  end
end
