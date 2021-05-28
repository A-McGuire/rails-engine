require 'rails_helper'

RSpec.describe 'Merchants with most items sold' do
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

    2.times do
      create(:invoice_item, item: item2, invoice: invoice2)
    end
    
    expect(Merchant.most_items_sold(1)).to eq([merchant2])
  end

  it 'defaults to 5 merchants returned' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    merchant5 = create(:merchant)
    merchant6 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    invoice3 = create(:invoice, merchant_id: merchant3.id, customer_id: customer.id)
    invoice4 = create(:invoice, merchant_id: merchant4.id, customer_id: customer.id)
    invoice5 = create(:invoice, merchant_id: merchant5.id, customer_id: customer.id)
    invoice6 = create(:invoice, merchant_id: merchant6.id, customer_id: customer.id)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)
    item4 = create(:item, merchant: merchant4)
    item5 = create(:item, merchant: merchant5)
    item6 = create(:item, merchant: merchant6)

    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'success')
    transaction4 = create(:transaction, invoice: invoice4, result: 'success')
    transaction5 = create(:transaction, invoice: invoice5, result: 'success')
    transaction6 = create(:transaction, invoice: invoice6, result: 'success')

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

    4.times do
      create(:invoice_item, item: item6, invoice: invoice6)
    end

    create(:invoice_item, item: item2, invoice: invoice2)
    
    expect(Merchant.most_items_sold).to eq([merchant4, merchant3, merchant5, merchant6, merchant1])
  end

  it 'counts the quantity of items' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    merchant5 = create(:merchant)
    merchant6 = create(:merchant)

    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    invoice3 = create(:invoice, merchant_id: merchant3.id, customer_id: customer.id)
    invoice4 = create(:invoice, merchant_id: merchant4.id, customer_id: customer.id)
    invoice5 = create(:invoice, merchant_id: merchant5.id, customer_id: customer.id)
    invoice6 = create(:invoice, merchant_id: merchant6.id, customer_id: customer.id)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)
    item4 = create(:item, merchant: merchant4)
    item5 = create(:item, merchant: merchant5)
    item6 = create(:item, merchant: merchant6)

    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'success')
    transaction4 = create(:transaction, invoice: invoice4, result: 'success')
    transaction5 = create(:transaction, invoice: invoice5, result: 'success')
    transaction6 = create(:transaction, invoice: invoice6, result: 'success')

    create(:invoice_item, item: item1, invoice: invoice1, quantity: 10)
    create(:invoice_item, item: item5, invoice: invoice5, quantity: 9)
    create(:invoice_item, item: item4, invoice: invoice4, quantity: 8)
    create(:invoice_item, item: item3, invoice: invoice3, quantity: 7)
    create(:invoice_item, item: item6, invoice: invoice6, quantity: 6)
    create(:invoice_item, item: item2, invoice: invoice2, quantity: 5)
    
    expect(Merchant.most_items_sold).to eq([merchant1, merchant5, merchant4, merchant3, merchant6])
  end
end