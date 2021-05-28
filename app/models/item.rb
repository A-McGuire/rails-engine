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
      where("name iLIKE :search", search: "%#{name}%")
      .order(:name)
    end

    def find_by_min_max(min, max)
      where("items.unit_price >= #{min} AND items.unit_price <= #{max}")
      .order(:name)
    end
  end
end
