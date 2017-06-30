class Api::V1::Merchants::TopMerchantsByItemsSoldController < ApplicationController

  def index
    render json: Merchant.top_ranked_by_items_sold(params[:quantity])
  end

  private
  def merchant_params
    params.permit(:quantity)
  end
end
