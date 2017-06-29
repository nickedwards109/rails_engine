class Api::V1::Merchants::MerchantFavoriteCustomersController < ApplicationController
  def show
    render json: Customer.favorite_customer(params[:id])
  end
end
