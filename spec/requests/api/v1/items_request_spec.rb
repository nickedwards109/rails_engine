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
    expect(item).to have_key("unit_price")
  end

  it "sends a single item" do
    item = create(:item, unit_price: "22.50")
    id = item.id

    get "/api/v1/items/#{id}.json"
    expect(response).to be_success

    raw_item = JSON.parse(response.body)
    expect(raw_item["name"]).to eq(item.name)
    expect(raw_item["description"]).to eq(item.description)
    expect(raw_item["unit_price"]).to eq("22.50")
  end

  it "sends an item selected by id, name, description, unit_price, created_at, or updated_at" do
    item = create(:item, unit_price: "22.50")

    get "/api/v1/items/find?id=#{item.id}"
    expect(response).to be_success
    raw_item = JSON.parse(response.body)
    expect(raw_item["id"]).to eq(item.id)

    get "/api/v1/items/find?name=#{item.name}"
    expect(response).to be_success
    raw_item = JSON.parse(response.body)
    expect(raw_item["name"]).to eq(item.name)

    get "/api/v1/items/find?description=#{item.description}"
    expect(response).to be_success
    raw_item = JSON.parse(response.body)
    expect(raw_item["description"]).to eq(item.description)

    get "/api/v1/items/find?unit_price=#{item.unit_price}"
    expect(response).to be_success
    raw_item = JSON.parse(response.body)
    expect(raw_item["unit_price"]).to eq("22.50")
  end

  it "sends an item using a case-insensitive query" do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name.upcase}"
    expect(response).to be_success
    raw_item = JSON.parse(response.body)
    expect(raw_item["name"]).to eq(item.name)

    get "/api/v1/items/find?description=#{item.description.upcase}"
    expect(response).to be_success
    raw_item = JSON.parse(response.body)
    expect(raw_item["description"]).to eq(item.description)
  end

  it "sends all items with a certain attribute value" do
    item1 = create(:item, name: "ItemName")
    item2 = create(:item, name: "ItemName")

    get '/api/v1/items/find_all?name=ItemName'
    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(2)
    expect(items.first["name"]).to eq("ItemName")
    expect(items.last["name"]).to eq("ItemName")
  end

  it "sends a random item" do
    item = create(:item)

    get '/api/v1/items/random.json'
    expect(response).to be_success
    raw_item = JSON.parse(response.body)
    expect(raw_item["name"]).to eq(item.name)
  end
end
