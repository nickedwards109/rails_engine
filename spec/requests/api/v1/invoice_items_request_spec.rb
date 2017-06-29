require 'rails_helper'

describe "Invoice_items API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items.json'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)

    invoice_item = invoice_items.first
    expect(invoice_item).to have_key("item_id")
    expect(invoice_item).to have_key("invoice_id")
    expect(invoice_item).to have_key("quantity")
    expect(invoice_item).to have_key("unit_price")
  end

  it "sends a single invoice_item" do
    invoice_item = create(:invoice_item)
    id = invoice_item.id

    get "/api/v1/invoice_items/#{id}.json"
    expect(response).to be_success

    raw_invoice_item = JSON.parse(response.body)
    expect(raw_invoice_item["item_id"]).to eq(invoice_item.item_id)
  end

  it "sends an invoice_item selected by id, item_id, invoice_id, quantity,
      created_at, or updated_at" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"
    expect(response).to be_success
    raw_invoice_item = JSON.parse(response.body)
    expect(raw_invoice_item["id"]).to eq(invoice_item.id)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"
    expect(response).to be_success
    raw_invoice_item = JSON.parse(response.body)
    expect(raw_invoice_item["item_id"]).to eq(invoice_item.item_id)
  end

  it "sends all invoice_items with a certain attribute value" do
    invoice_item1 = create(:invoice_item, quantity: 4)
    invoice_item2 = create(:invoice_item, quantity: 4)

    get '/api/v1/invoice_items/find_all?quantity=4'
    expect(response).to be_success

    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first["quantity"]).to eq(4)
    expect(invoice_items.last["quantity"]).to eq(4)
  end

  it "sends a random invoice_item" do
    invoice_item = create(:invoice_item)

    get '/api/v1/invoice_items/random.json'
    expect(response).to be_success
    raw_invoice_item = JSON.parse(response.body)
    expect(raw_invoice_item["quantity"]).to eq(invoice_item.quantity)
  end
end
