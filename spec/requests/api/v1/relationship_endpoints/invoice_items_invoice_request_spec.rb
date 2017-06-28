require 'rails_helper'

describe "Invoice Items API" do
  it "returns an invoice associated with a given invoice item" do
    merch_1 = Merchant.create(name: "Test Merchant")
    customer_1 = Customer.create(first_name: "Test", last_name: "Customer")
    invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: merch_1.id)
    item_1 = Item.create!(name: "Great Item", unit_price: 40, merchant_id: merch_1.id)
    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, quantity: 5, item_id: item_1.id, unit_price: item_1.unit_price)

    get "/api/v1/invoice_items/#{invoice_item_1.id}/invoice"

    expect(response).to be_success
    invoice = JSON.parse(response.body)
    expect(invoice["customer_id"]).to eq(customer_1.id)
  end
end