FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number "MyText"
    credit_card_expiration_date "2017-06-27"
    result "MyString"
  end
end
