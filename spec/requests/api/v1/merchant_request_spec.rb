require 'rails_helper'

describe "Merchants API " do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)

    merchant = merchants.first
    expect(merchant).to have_key("name")

  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "can find a merchant by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq(name)
  end

# not yet passing
  xit "can find a merchant by created date" do
    created = create(:merchant).formatted_create
    get "/api/v1/merchants/find?created_at=#{created}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["created_at"]).to eq(created)
  end

  xit "can find a merchant by updated date" do
    updated = create(:merchant).formatted_update
    get "/api/v1/merchants/find?updated_at=#{updated}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["updated_at"]).to eq(updated)
  end

  it "can find a merchant's associated items" do
    merchant = Merchant.create(name: "MerchantName")
    item1 = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_success

    raw_items = JSON.parse(response.body)
    expect(raw_items.count).to eq(2)
    expect([item1.id, item2.id]).to include(raw_items.first["id"])
    expect([item1.id, item2.id]).to include(raw_items.last["id"])
    expect(raw_items.first[:name]).to be_nil
    expect(raw_items.first[:description]).to be_nil
    expect(raw_items.first[:unit_price]).to be_nil
  end
end
