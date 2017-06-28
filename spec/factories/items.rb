FactoryGirl.define do
  factory :item do
    merchant
    name "Item Name"
    description "Item Description"
    unit_price "22.50"
  end
end
