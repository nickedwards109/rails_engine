class Api::V1::Invoices::RandomInvoiceController < ApplicationController
  def show
    render json: Invoice.order("RANDOM()").first
  end
end
