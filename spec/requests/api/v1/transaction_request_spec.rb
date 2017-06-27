require 'rails_helper'

describe "Transactions API " do
  it "sends a list of transactions" do
    invoice = create(:invoice)
    create_list(:transaction, 3, invoice: invoice)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end

  it "can get one transaction by its id" do
    invoice = create(:invoice)
    id = create(:transaction, invoice: invoice).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  xit "can find a transaction by credit card number" do
    invoice = create(:invoice)
    card_number = create(:transaction, invoice: invoice).credit_card_number

    get "/api/v1/transactions/find?credit_card_number=#{card_number}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["credit_card_number"]).to eq(card_number)
  end
end