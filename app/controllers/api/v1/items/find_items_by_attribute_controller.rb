class Api::V1::Items::FindItemsByAttributeController < ApplicationController
  def show
    render json: Item.find_case_insensitive(item_params)
  end

  def index
    render json: Item.find_all_case_insensitive(item_params)
  end

  private
  def item_params
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
  end
end
