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
end
