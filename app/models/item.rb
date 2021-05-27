class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items, dependent: :destroy
  class << self
    def items_merchant(item_id)
      find(item_id).merchant
    end

    def find_all(name)
      where("name iLIKE :iq", iq: "%#{name}%")
      .order(:name)
    end
  end
end
