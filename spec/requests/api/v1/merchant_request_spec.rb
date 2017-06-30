require 'rails_helper'

describe "Merchants API " do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)

    merchant = merchants.first
    expect(merchant).to have_key("name")

  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "can find a merchant by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq(name)
  end


  xit "can find a merchant by created date" do
    created = create(:merchant).created_at
    get "/api/v1/merchants/find?created_at=#{created}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["created_at"]).to eq(created)
  end

  xit "can find a merchant by updated date" do
    updated = create(:merchant).updated_at
    get "/api/v1/merchants/find?updated_at=#{updated}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["updated_at"]).to eq(updated)
  end

  it "can find a random merchant" do
    merchants = create_list(:merchant, 3)

    get "/api/v1/merchants/random"

    JSON.parse(response.body)

    expect(response).to be_success
  end

  it "can find a merchant's associated items" do
    merchant = Merchant.create(name: "MerchantName")
    item1 = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items.json"
    expect(response).to be_success

    raw_items = JSON.parse(response.body)
    expect(raw_items.count).to eq(2)
    expect([item1.id, item2.id]).to include(raw_items.first["id"])
    expect([item1.id, item2.id]).to include(raw_items.last["id"])
  end

  it "can find a merchant's associated invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/merchants/#{merchant.id}/invoices.json"
    expect(response).to be_success

    raw_invoices = JSON.parse(response.body)
    expect(raw_invoices.count).to eq(2)
    expect([invoice1.id, invoice2.id]).to include(raw_invoices.first["id"])
    expect([invoice1.id, invoice2.id]).to include(raw_invoices.last["id"])
  end

  it "can find a merchant's customer who has created the most successful transactions" do
    good_customer = create(:customer)
    bad_customer = create(:customer)
    merchant = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant)
    invoice2 = create(:invoice, merchant: merchant)
    invoice3 = create(:invoice, merchant: merchant)
    invoice4 = create(:invoice, merchant: merchant)

    successful_transaction_1 = create(:transaction, invoice: invoice1, result: "success")
    successful_transaction_2 = create(:transaction, invoice: invoice2, result: "success")
    successful_transaction_3 = create(:transaction, invoice: invoice3, result: "success")
    unsuccessful_transaction = create(:transaction, invoice: invoice4, result: "failed")

    successful_transaction_1.customer = good_customer
    successful_transaction_2.customer = good_customer
    successful_transaction_3.customer = bad_customer
    unsuccessful_transaction.customer = bad_customer

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    expect(response).to be_success

    raw_customer = JSON.parse(response.body)
    expect(raw_customer["id"]).to eq(good_customer.id)
    expect(raw_customer["first_name"]).to eq(good_customer.first_name)
  end

  it "can find a merchant's total revenue across all successful transactions" do
    merchant = create(:merchant)
    success_invoice = create(:invoice, merchant_id: merchant.id)
    success_invoice_item1 = create(:invoice_item, unit_price: "2250",
                            invoice_id: success_invoice.id, quantity: 1)
    success_invoice_item2 = create(:invoice_item, unit_price: "2250",
                            invoice_id: success_invoice.id, quantity: 2)
    success_transaction_1 = create(:transaction, invoice_id: success_invoice.id,
                            result: "success")

    failed_invoice = create(:invoice, merchant_id: merchant.id)
    failed_invoice_item1 = create(:invoice_item, unit_price: "2250",
                           invoice_id: failed_invoice.id, quantity: 1)
    failed_transaction_1 = create(:transaction, invoice_id: failed_invoice.id,
                           result: "failed")

    get "/api/v1/merchants/#{merchant.id}/revenue"
    expect(response).to be_success

    raw_revenue = JSON.parse(response.body)
    expect(raw_revenue["revenue"]).to eq("6750.00")
  end

  it "can find a merchant's total revenue across all successful transactions, scoped to a date" do
    merchant = create(:merchant)
    date1 = "2012-03-16 11:55:05"
    date2 = "2012-03-17 11:55:05"
    invoice_date1 = create(:invoice, merchant_id: merchant.id, created_at: date1)
    invoice_item1_date1 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice_date1.id, quantity: 1)
    invoice_item2_date1 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice_date1.id, quantity: 2)
    transaction_date1 = create(:transaction, invoice_id: invoice_date1.id)

    invoice_date2 = create(:invoice, merchant_id: merchant.id, created_at: date2)
    invoice_item1_date2 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice_date2.id, quantity: 1)
    invoice_item2_date2 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice_date2.id, quantity: 1)
    transaction_date2 = create(:transaction, invoice_id: invoice_date2.id)

    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{date1}"
    expect(response).to be_success

    raw_revenue = JSON.parse(response.body)
    expect(raw_revenue["revenue"]).to eq("6750.00")
  end

  it "can find all merchants' total revenue across all successful transactions, scoped to a date" do
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

    get "/api/v1/merchants/revenue?date=#{date1}"
    expect(response).to be_success

    raw_revenue = JSON.parse(response.body)
    expect(raw_revenue["total_revenue"]).to eq("13500.00")
  end

  it "can find a variable number of top merchants ranked by revenue" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice1_item1 = create(:invoice_item, unit_price: "5250",
                           invoice_id: invoice1.id, quantity: 1)
    invoice1_item2 = create(:invoice_item, unit_price: "5250",
                           invoice_id: invoice1.id, quantity: 2)
    transaction1 = create(:transaction, invoice_id: invoice1.id)

    invoice2 = create(:invoice, merchant_id: merchant2.id)
    invoice2_item1 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice2.id, quantity: 1)
    invoice2_item2 = create(:invoice_item, unit_price: "2250",
                           invoice_id: invoice2.id, quantity: 2)
    transaction2 = create(:transaction, invoice_id: invoice2.id)

    get '/api/v1/merchants/most_revenue?quantity=1'
    expect(response).to be_success
    raw_merchants = JSON.parse(response.body)
    expect(raw_merchants.first["id"]).to eq(merchant1.id)
    expect(raw_merchants.length).to eq(1)

    get '/api/v1/merchants/most_revenue?quantity=2'
    expect(response).to be_success
    raw_merchants = JSON.parse(response.body)
    expect(raw_merchants.first["id"]).to eq(merchant1.id)
    expect(raw_merchants.last["id"]).to eq(merchant2.id)
    expect(raw_merchants.length).to eq(2)
  end

  it "can find a variable number of top merchants ranked by number of items sold" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice1_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 5)
    invoice1_item2 = create(:invoice_item, invoice_id: invoice1.id, quantity: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id)

    invoice2 = create(:invoice, merchant_id: merchant2.id)
    invoice2_item1 = create(:invoice_item, invoice_id: invoice2.id, quantity: 1)
    invoice2_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 1)
    transaction2 = create(:transaction, invoice_id: invoice2.id)

    get '/api/v1/merchants/most_items?quantity=1'
    expect(response).to be_success
    raw_merchants = JSON.parse(response.body)
    expect(raw_merchants.first["id"]).to eq(merchant1.id)
    expect(raw_merchants.length).to eq(1)

    get '/api/v1/merchants/most_items?quantity=2'
    expect(response).to be_success
    raw_merchants = JSON.parse(response.body)
    expect(raw_merchants.first["id"]).to eq(merchant1.id)
    expect(raw_merchants.last["id"]).to eq(merchant2.id)
    expect(raw_merchants.length).to eq(2)
  end

  it "can find a merchant's customers who have not paid their invoices" do
    good_customer = create(:customer)
    bad_customer = create(:customer)
    merchant = create(:merchant)

    paid_invoice = create(:invoice, merchant_id: merchant.id,
                          customer_id: good_customer.id)
    paid_transaction = create(:transaction, invoice_id: paid_invoice.id,
                              result: "success")

    unpaid_invoice = create(:invoice, merchant_id: merchant.id,
                            customer_id: bad_customer.id)
    unpaid_transaction = create(:transaction, invoice_id: unpaid_invoice.id,
                                result: "failed")

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"
    expect(response).to be_success

    raw_customers = JSON.parse(response.body)
    expect(raw_customers.first["id"]).to eq(bad_customer.id)
    expect(raw_customers.length).to eq(1)
  end
end
