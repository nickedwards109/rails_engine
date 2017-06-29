FactoryGirl.define do
  factory :item do
    merchant
    name "Item Name"
    description "Item Description"
    unit_price "2250"
  end
end
