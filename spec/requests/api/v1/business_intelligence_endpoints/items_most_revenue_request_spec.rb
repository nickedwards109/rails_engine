require 'rails_helper'

describe 'most_revenue' do
  it "returns items with the greatest revenue" do
    items = Item.all
    merchant_1 = Merchant.create!(name: "Test Merchant 1")
    merchant_2 = Merchant.create!(name: "Test Merchant 2")
    item_1 = Item.create!(name: "Good Item", unit_price: 5, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: "Great Item", unit_price: 7, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: "Best Item", unit_price: 9, merchant_id: merchant_2.id)
    customer = Customer.create!(first_name: "Test", last_name: "Customer")
    invoice_1 = Invoice.create!(merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = Invoice.create!(merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, quantity: 7, item_id: item_1.id, unit_price: item_1.unit_price)
    invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_1.id, quantity: 14, item_id: item_2.id, unit_price: item_2.unit_price)
    invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_2.id, quantity: 21, item_id: item_3.id, unit_price: item_3.unit_price)
    transaction_1 = Transaction.create!(invoice_id: invoice_1.id, result: "success")
    transaction_2 = Transaction.create!(invoice_id: invoice_2.id, result: "success")


    get '/api/v1/items/most_revenue?quantity=3'

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
    expect(items.first['name']).to eq(item_3.name)
  end
end