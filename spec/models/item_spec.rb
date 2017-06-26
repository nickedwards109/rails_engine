require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a name and description" do
    item = Item.create(name: "Item Name", description: "Item Description")
    expect(item).to be_valid
    expect(item).to respond_to(:name)
    expect(item).to respond_to(:description)
  end
end
