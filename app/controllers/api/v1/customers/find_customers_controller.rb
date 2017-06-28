class Api::V1::Customers::FindCustomersController < ApplicationController

  def index
    render json: Customer.where(find_customer_params)
  end

  def show
    render json: Customer.find_by(find_customer_params)
  end

  private

  def find_customer_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end

end