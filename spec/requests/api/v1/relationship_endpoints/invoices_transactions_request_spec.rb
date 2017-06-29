require 'rails_helper'

describe "Invoice API" do
  it "returns a list of transactions for a given invoice" do
    merchant_1 = Merchant.create(name: "Test Merchant")
    customer_1 = Customer.create(first_name: "Test", last_name: "Customer")
    invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: merchant_1.id)

    transaction_1 = Transaction.create(credit_card_number: "4242424242424242", invoice_id: invoice_1.id, result: "success")
    transaction_2 = Transaction.create(credit_card_number: "4242424242424123",invoice_id: invoice_1.id, result: "success")
    transaction_3 = Transaction.create(credit_card_number: "4242424242421234",invoice_id: invoice_1.id, result: "success")


    get "/api/v1/invoices/#{invoice_1.id}/transactions"

    expect(response).to be_success
    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(3)
  end
end