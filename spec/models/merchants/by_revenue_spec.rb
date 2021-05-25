require 'rails_helper'

RSpec.describe 'Merchants with most revenue, with required quantity param' do
  it 'returns the top merchant' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)

    transaction1 = create(:transaction, invoice: invoice1, result: 'success')

    transaction2 = create(:transaction, invoice: invoice2, result: 'success')

    create(:invoice_item, item: item1, invoice: invoice1)

    create(:invoice_item, item: item2, invoice: invoice2)
    
    expect(Merchant.by_total_revenue(1)).to eq([merchant1])
  end
end