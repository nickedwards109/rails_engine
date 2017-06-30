require 'rails_helper'

describe "favorite_customer" do
  it "returns a customer's most frequented merchant" do
    customer = Customer.create!(first_name: "Test", last_name: "Customer")
    merchant_1 = Merchant.create!(name: "Good Merchant")
    merchant_2 = Merchant.create!(name: "Won't Scam You")

    invoice_1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_2.id)
    invoice_3 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_2.id)

    transaction_1 = Transaction.create!(invoice_id: invoice_1.id, result: "success")
    transaction_2 = Transaction.create!(invoice_id: invoice_2.id, result: "success")
    transaction_3 = Transaction.create!(invoice_id: invoice_3.id, result: "success")


    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq("Won't Scam You")
  end
end