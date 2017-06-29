class Api::V1::Transactions::TransactionInvoicesController < ApplicationController
  def show
    render json: Transaction.find(params[:id]).invoice
  end
end
