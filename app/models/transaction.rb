class Transaction < ApplicationRecord
  belongs_to :invoice
  has_one :customer, through: :invoice

  scope :successful, -> {where(result: 'success')}
end
