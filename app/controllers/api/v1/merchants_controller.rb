class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find_by(params[:id])
  end
end
