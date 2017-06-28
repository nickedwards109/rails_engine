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
end
