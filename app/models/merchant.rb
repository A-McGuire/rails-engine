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
      .where("invoices.status = ?", 'shipped')
      .group(:id)
      .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .order(revenue: :desc)
      .limit(quantity)
    end

    def most_items_sold(quantity = 5)
      joins(items: {invoice_items: {invoice: :transactions}})
      .where("transactions.result = ?", 'success')
      .group(:id)
      .select("merchants.*, sum(invoice_items.quantity) as item_count")
      .limit(quantity)
      .order(item_count: :desc)
    end

    def find_one(name)
      where("name iLIKE :search", search: "%#{name.downcase}%")
      .order(:name)
      .limit(1)
      .first
    end

    def total_revenue_by_dates(start_date, end_date)
      binding.pry
      joins(items: {invoice_items: {invoice: :transactions}})
    end
  end
end