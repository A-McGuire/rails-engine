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

    def by_total_revenue(quantity)
      joins(items: {invoice_items: {invoice: :transactions}})
      .where("transactions.result = ?", 'success')
      .group(:id)
      .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .order(revenue: :desc)
      .limit(quantity)
    end

    def most_items_sold(quantity = 5)
      joins(items: {invoice_items: {invoice: :transactions}})
      .where("transactions.result = ?", 'success')
      .group(:id)
      .select("merchants.*, sum(invoice_items.quantity) as count")
      .order(count: :desc)
      .limit(quantity)
    end
  end
end