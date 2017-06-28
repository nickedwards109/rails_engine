class Api::V1::Merchants::FindMerchantsController < ApplicationController

  def index
    render json: Merchant.where(find_merchants_params)
  end

  def show
    render json: Merchant.find_by(find_merchants_params)
  end
  
  private

  def find_merchants_params
    params.permit(:id, :name, :created_at, :updated_at)
  end

end