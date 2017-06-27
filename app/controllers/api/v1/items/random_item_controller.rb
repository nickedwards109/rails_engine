class Api::V1::Items::RandomItemController < ApplicationController
  def show
    render json: Item.order("RANDOM()").first
  end
end
