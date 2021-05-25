class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  
  class << self
    def merchant_items(merchant_id)
      find(merchant_id).items
    end

    def by_total_revenue(number)
      joins(items: {invoice_items: {invoice: :transactions}})
      .where("transactions.result = ?", 'success')
      .group(:id)
      .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
      .order(total_revenue: :desc)
      .limit(number)
    end
  end
end