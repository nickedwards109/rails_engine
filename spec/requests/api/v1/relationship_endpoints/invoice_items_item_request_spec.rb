require 'rails_helper'

describe "Invoice Items API" do
  it "returns items associated with a given invoice item" do
    merch_1 = Merchant.create(name: "Test Merchant")
    customer_1 = Customer.create(first_name: "Test", last_name: "Customer")
    invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: merch_1.id)
    item_1 = Item.create!(name: "thing", unit_price: 50, merchant_id: merch_1.id)
    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, quantity: 17, item_id: item_1.id, unit_price: item_1.unit_price)

    get "/api/v1/invoice_items/#{invoice_item_1.id}/item"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["unit_price"]).to eq(item_1.unit_price)
  end
end