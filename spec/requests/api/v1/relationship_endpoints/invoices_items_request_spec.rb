require 'rails_helper'

describe "Invoice API" do
  it "returns a list of items for a given invoice" do
    merchant_1 = Merchant.create(name: "Test Merchant")
    customer_1 = Customer.create(first_name: "Test", last_name: "Customer")
    invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: merchant_1.id)
    item_1 = Item.create!(name: "Good Item", unit_price: 10, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: "Great Item", unit_price: 20, merchant_id: merchant_1.id)
    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, quantity: 2, item_id: item_1.id, unit_price: item_1.unit_price)
    invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_1.id, quantity: 1, item_id: item_2.id, unit_price: item_2.unit_price)

    get "/api/v1/invoices/#{invoice_1.id}/items"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(2)
  end
end