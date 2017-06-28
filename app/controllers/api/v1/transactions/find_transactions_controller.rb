class Api::V1::Transactions::FindTransactionsController < ApplicationController

  def show
    render json: Transaction.find_by(find_transactions_params)
  end

  def index
    render json: Transaction.where(find_transactions_params)
  end

  private

  def find_transactions_params
    params.permit(:id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end

end