require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it "has a status" do
    merchant = Merchant.create(name: "MerchantName")
    customer = Customer.create(first_name: "FirstName", last_name: "LastName")
    item = Item.create(
                       name: "Item Name",
                       description: "Item Description",
                       unit_price: "25.00",
                       merchant_id: merchant.id
                       )
    invoice = Invoice.create(
                             status: "shipped",
                             merchant_id: merchant.id,
                             customer_id: customer.id
                             )
    expect(invoice).to be_valid
    expect(invoice).to respond_to(:status)
  end

  it "can find the total revenue across all successful transactions, scoped to a date" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    date1 = "2012-03-16 11:55:05"
    date2 = "2012-03-17 11:55:05"

    invoice1_date1 = create(:invoice, merchant_id: merchant1.id, created_at: date1)
    invoice1_item1_date1 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice1_date1.id, quantity: 1)
    invoice1_item2_date1 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice1_date1.id, quantity: 2)
    transaction1_date1 = create(:transaction, invoice_id: invoice1_date1.id)

    invoice2_date1 = create(:invoice, merchant_id: merchant2.id, created_at: date1)
    invoice2_item1_date1 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice2_date1.id, quantity: 1)
    invoice2_item2_date1 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice2_date1.id, quantity: 2)
    transaction2_date1 = create(:transaction, invoice_id: invoice2_date1.id)

    invoice_date2 = create(:invoice, merchant_id: merchant1.id, created_at: date2)
    invoice_item1_date2 = create(:invoice_item, unit_price: "3250",
                           invoice_id: invoice_date2.id, quantity: 1)
    invoice_item2_date2 = create(:invoice_item, unit_price: "3250",
                           invoice_id: invoice_date2.id, quantity: 1)
    transaction_date2 = create(:transaction, invoice_id: invoice_date2.id)

    expect(Invoice.total_revenue_scoped_to(date1)[:total_revenue]).to eq("13500.00")
  end
end
