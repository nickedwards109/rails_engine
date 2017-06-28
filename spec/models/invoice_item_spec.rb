require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it "belongs to an item and an invoice" do
    merchant = Merchant.create(name: "MerchantName")
    item = Item.create(
                       name: "Item Name",
                       description: "Item Description",
                       unit_price: "25.00",
                       merchant_id: merchant.id)
    invoice = Invoice.create(status: "shipped")
    invoice_item = InvoiceItem.create(
                                      item_id: item.id,
                                      invoice_id: invoice.id,
                                      quantity: 2,
                                      unit_price: item.unit_price
                                      )
    expect(invoice_item).to be_valid
    expect(invoice_item.unit_price).to eq(item.unit_price)
  end
end
