require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)

    item = items.first
    expect(item).to have_key("name")
    expect(item).to have_key("description")
  end

  it "sends a single item" do
    item = create(:item)
    id = item.id

    get "/api/v1/items/#{id}.json"
    expect(response).to be_success

    raw_item = JSON.parse(response.body)
    expect(raw_item["name"]).to eq(item.name)
    expect(raw_item["description"]).to eq(item.description)
  end
end
