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
    2.times do
      create(:invoice_item, item: item1, invoice: invoice1)
    end

    create(:invoice_item, item: item2, invoice: invoice2)
    
    expect(Merchant.by_total_revenue(1)).to eq([merchant1])
  end

  it 'returns more than one merchant' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    merchant5 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    invoice3 = create(:invoice, merchant_id: merchant3.id, customer_id: customer.id)
    invoice4 = create(:invoice, merchant_id: merchant4.id, customer_id: customer.id)
    invoice5 = create(:invoice, merchant_id: merchant5.id, customer_id: customer.id)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)
    item4 = create(:item, merchant: merchant4)
    item5 = create(:item, merchant: merchant5)

    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'success')
    transaction4 = create(:transaction, invoice: invoice4, result: 'success')
    transaction5 = create(:transaction, invoice: invoice5, result: 'success')

    2.times do
      create(:invoice_item, item: item1, invoice: invoice1)
    end

    5.times do
      create(:invoice_item, item: item5, invoice: invoice5)
    end

    12.times do
      create(:invoice_item, item: item4, invoice: invoice4)
    end

    10.times do
      create(:invoice_item, item: item3, invoice: invoice3)
    end

    create(:invoice_item, item: item2, invoice: invoice2)
    
    expect(Merchant.by_total_revenue(5)).to eq([merchant4, merchant3, merchant5, merchant1, merchant2])
  end

  it 'accounts for the transaction status' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)

    transaction1 = create(:transaction, invoice: invoice1, result: 'failed')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')

    create(:invoice_item, item: item1, invoice: invoice1)
    create(:invoice_item, item: item2, invoice: invoice2)
    
    expect(Merchant.by_total_revenue(5)).to eq([merchant2])
  end
end