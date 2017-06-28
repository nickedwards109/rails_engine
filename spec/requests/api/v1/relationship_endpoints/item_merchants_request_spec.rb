require 'rails_helper'

describe "item API" do
  it "can load the merchant of a given item" do
    merchant1 = Merchant.create(name: "Merchant 1")
    item1 = Item.create(name: "Item1", merchant_id: merchant1.id)

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_success
    merchant = JSON.parse(response.body)
    expect(merchant["name"]).to eq("Merchant 1")
  end
end