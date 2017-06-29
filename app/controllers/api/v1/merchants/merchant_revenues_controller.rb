class Api::V1::Merchants::MerchantRevenuesController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).total_revenue
  end
end
