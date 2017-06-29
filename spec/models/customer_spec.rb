require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "finds a merchant's favorite customer" do
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

    expect(Customer.favorite_customer(merchant.id).id).to eq(good_customer.id)
  end
end
