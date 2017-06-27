require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it "has a status" do
    invoice = Invoice.create(status: "shipped")
    expect(invoice).to be_valid
    expect(invoice).to respond_to(:status)
  end
end
