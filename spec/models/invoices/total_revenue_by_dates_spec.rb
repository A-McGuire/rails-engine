require 'rails_helper'
RSpec.describe 'total_revenue_by_dates(start, end)' do
  it 'only returns the revenue for the date range' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    
    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id, status: 'shipped', created_at: '2012-03-09')
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id, status: 'shipped', created_at: '2012-03-10') 
    invoice3 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id, status: 'shipped', created_at: '2012-03-24') 
    invoice4 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id, status: 'shipped', created_at: '2012-03-23')
    invoice5 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id, status: 'pending', created_at: '2012-03-25') #not counted, date range
    invoice6 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id, status: 'pending', created_at: '2012-03-08') #not counted, date range
    invoice7 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id, status: 'shipped', created_at: '2012-03-10') #not counted, transaction failed

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)

    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'success') 
    transaction4 = create(:transaction, invoice: invoice4, result: 'success') 
    transaction5 = create(:transaction, invoice: invoice5, result: 'success') 
    transaction6 = create(:transaction, invoice: invoice6, result: 'success')
    transaction7 = create(:transaction, invoice: invoice6, result: 'failed')

    create(:invoice_item, item: item1, invoice: invoice1) #unit_price 10, quantity 10, revenue => 100
    create(:invoice_item, item: item2, invoice: invoice2)
    create(:invoice_item, item: item1, invoice: invoice3) 
    create(:invoice_item, item: item2, invoice: invoice4) 
    create(:invoice_item, item: item1, invoice: invoice5) 
    create(:invoice_item, item: item2, invoice: invoice6) 
    create(:invoice_item, item: item1, invoice: invoice7) 
    
    expect(Invoice.total_revenue_by_dates('2012-03-09', '2012-03-24')).to eq(400)
  end
end