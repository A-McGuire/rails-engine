class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items

  class << self
    def find_empty
      left_outer_joins(:invoice_items).where(invoice_items: { id: nil })
    end
  
    def total_revenue_by_dates(start_date, end_date)
      joins(:transactions)
      .joins(:invoice_items)
      .where("transactions.result = ?", 'success')
      .where("invoices.status = ?", 'shipped')
      .where('invoices.created_at BETWEEN ? AND ?', start_date, end_date)
      .sum("invoice_items.unit_price * invoice_items.quantity")
    end
  end
end
