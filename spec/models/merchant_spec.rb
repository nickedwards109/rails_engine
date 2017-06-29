require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "finds the merchant's favorite customer" do
    good_customer = create(:customer)
    bad_customer = create(:customer)
    merchant = create(:merchant)

    successful_transaction_1 = create(:transaction, result: "success")
    successful_transaction_2 = create(:transaction, result: "success")
    successful_transaction_3 = create(:transaction, result: "success")
    unsuccessful_transaction = create(:transaction, result: "success")

    successful_transaction_1.customer = good_customer
    successful_transaction_2.customer = good_customer
    successful_transaction_3.customer = bad_customer
    unsuccessful_transaction.customer = bad_customer

    expect(merchant.favorite_customer).to eq(good_customer)
  end
end
