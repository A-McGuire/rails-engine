require 'rails_helper'
RSpec.describe 'total_revenue_by_dates(start, end)' do
  it 'only returns the revenue for the date range' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id, status: 'shipped')
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id, status: 'shipped')
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)

    transaction1 = create(:transaction, invoice: invoice1, result: 'success', updated_at: '2012-03-09') #200
    transaction2 = create(:transaction, invoice: invoice2, result: 'success', updated_at: '2012-03-10') #100
    transaction3 = create(:transaction, invoice: invoice2, result: 'success', updated_at: '2012-03-08') #outside date range, not counted
    transaction4 = create(:transaction, invoice: invoice2, result: 'failed', updated_at: '2012-03-10') #failed, no counted

    2.times do
      create(:invoice_item, item: item1, invoice: invoice1) #unit_price 10, quantity 10, revenue => 200
    end

    create(:invoice_item, item: item2, invoice: invoice2)#unit_price 10, quantity 10, revenue => 100
    
    expect(Merchant.total_revenue_by_dates('2012-03-09', '2012-03-24')).to eq(300)
  end
end