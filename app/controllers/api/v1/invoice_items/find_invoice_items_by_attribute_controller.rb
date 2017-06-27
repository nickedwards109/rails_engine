class Api::V1::InvoiceItems::FindInvoiceItemsByAttributeController < ApplicationController
  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  private
  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity)
  end
end
