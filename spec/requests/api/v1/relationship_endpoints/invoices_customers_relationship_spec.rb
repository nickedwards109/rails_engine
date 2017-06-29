require 'rails_helper'

describe "Invoice API" do
  it "returns a customer associated with a given invoice" do
    merch_1 = Merchant.create(name: "Test Merchant")
    customer_1 = Customer.create(first_name: "Test", last_name: "Customer")
    invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: merch_1.id)

    get "/api/v1/invoices/#{invoice_1.id}/customer"

    expect(response).to be_success
    customer = JSON.parse(response.body)
    expect(customer["first_name"]).to eq(customer_1.first_name)
  end
end