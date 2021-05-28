require 'rails_helper'

RSpec.describe 'Merchant total revenue' do
  it 'returns the total revenue for a merchant' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")
    merchant = Merchant.create!(name: "AAA")
    item = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
    invoice = customer.invoices.create!(status: 'shipped')
    transaction = invoice.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 'success')
    invoice_item = InvoiceItem.create!(item: item, invoice: invoice, quantity: 1, unit_price: 5)
    invoice_item = InvoiceItem.create!(item: item, invoice: invoice, quantity: 1, unit_price: 5)
    invoice_item = InvoiceItem.create!(item: item, invoice: invoice, quantity: 1, unit_price: 5)

    expect(merchant.total_revenue).to eq(15)
  end
end