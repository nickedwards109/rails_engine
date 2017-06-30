class Api::V1::Merchants::UnpaidInvoicesController < ApplicationController
  def index
    render json: Customer.unpaid_invoices(params[:id])
  end
end
