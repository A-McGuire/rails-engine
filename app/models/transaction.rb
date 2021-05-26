class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true, numericality: true
  validates :result, presence: true

  belongs_to :invoice
end
