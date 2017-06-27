class Api::V1::Items::FindItemByAttributeController < ApplicationController
  def show
    render json: Item.find_by(item_params)
  end

  private
  def item_params
    params.permit(:id, :name, :description, :unit_price)
  end
end
