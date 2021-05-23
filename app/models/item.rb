class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  class << self
    def all_items(page_number = 1, per_page = 20)
      page_number = 1 if page_number <= 0
      Item.all.limit(per_page).offset((page_number - 1) * per_page)
    end
  end
end
