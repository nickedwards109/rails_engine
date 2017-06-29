class Api::V1::Items::ItemMerchantsController < ApplicationController
  def index
    render json: Item.find(params[:id]).merchant
  end
end