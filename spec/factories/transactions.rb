FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number "4242 4242 4242 4242"
    credit_card_expiration_date "2017-06-27"
    result "success"
  end
end
