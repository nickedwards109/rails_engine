require 'rails_helper'

describe "Invoice API" do
  it "returns a merchant associated with a given invoice" do
    merchant_1 = Merchant.create(name: "Test Merchant")
    customer_1 = Customer.create(first_name: "Test", last_name: "Customer")
    invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: merchant_1.id)

    get "/api/v1/invoices/#{invoice_1.id}/merchant"

    expect(response).to be_success
    merchant = JSON.parse(response.body)
    expect(merchant["name"]).to eq(merchant_1.name)
  end
end