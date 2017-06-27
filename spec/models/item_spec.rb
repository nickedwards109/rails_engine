require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a name and description" do
    merchant = Merchant.create(name: "MerchantName")
    item = Item.create(
                       name: "Item Name",
                       description: "Item Description",
                       merchant_id: merchant.id)
    expect(item).to be_valid
    expect(item).to respond_to(:name)
    expect(item).to respond_to(:description)
    expect(item).to respond_to(:merchant_id)
  end
end
