class Api::V1::Merchants::MerchantItemsController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).items.select(:id)
  end
end
