class Api::V1::Merchants::MerchantRevenuesController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).total_revenue(params[:date])
  end

  private
  def merchant_params
    params.permit(:id, :date)
  end
end
