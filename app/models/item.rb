class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  class << self
    def merchant_items(merchant_id)
      binding.pry
    end
  end
end
