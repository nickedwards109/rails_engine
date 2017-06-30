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

  it "can find a merchant's customers who have not paid their invoices" do
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer)
    merchant = create(:merchant)

    paid_invoice1 = create(:invoice, merchant_id: merchant.id,
                          customer_id: customer1.id)
    paid_transaction1 = create(:transaction, invoice_id: paid_invoice1.id,
                              result: "success")
    unpaid_invoice1 = create(:invoice, merchant_id: merchant.id,
                            customer_id: customer1.id)
    unpaid_transaction1 = create(:transaction, invoice_id: unpaid_invoice1.id,
                                result: "failed")

    unpaid_invoice2 = create(:invoice, merchant_id: merchant.id,
                            customer_id: customer2.id)
    unpaid_transaction2 = create(:transaction, invoice_id: unpaid_invoice2.id,
                                result: "failed")

    unpaid_invoice3 = create(:invoice, merchant_id: merchant.id,
                            customer_id: customer3.id)
    unpaid_transaction3 = create(:transaction, invoice_id: unpaid_invoice3.id,
                                result: "failed")

    expect([
    Customer.unpaid_invoices(merchant.id).first[:id],
    Customer.unpaid_invoices(merchant.id).last[:id],
    ]).to include(customer2.id)

    expect([
    Customer.unpaid_invoices(merchant.id).first[:id],
    Customer.unpaid_invoices(merchant.id).last[:id],
    ]).to include(customer3.id)
    
    expect(Customer.unpaid_invoices(merchant.id).length).to eq(2)
  end
end
