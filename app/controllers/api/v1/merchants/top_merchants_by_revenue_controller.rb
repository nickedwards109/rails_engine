class Api::V1::Merchants::TopMerchantsByRevenueController < ApplicationController

  def index
    render json: Merchant.top_ranked_by_revenue(params[:quantity])
  end

  private
  def merchant_params
    params.permit(:quantity)
  end
end
