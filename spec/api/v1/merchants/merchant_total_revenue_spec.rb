require 'rails_helper'

RSpec.describe 'merchant total revenue' do

  it 'can get one merchants total revenue' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")
    merchant = Merchant.create!(id: 1, name: "AAA")
    item = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
    invoice = customer.invoices.create!(status: 'shipped')
    transaction = invoice.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 'success')
    invoice_item = InvoiceItem.create!(item: item, invoice: invoice, quantity: 1, unit_price: 5)
    invoice_item = InvoiceItem.create!(item: item, invoice: invoice, quantity: 1, unit_price: 5)
    invoice_item = InvoiceItem.create!(item: item, invoice: invoice, quantity: 1, unit_price: 5)

    get '/api/v1/revenue/merchants/1'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a Hash
    expect(merchant).to have_key(:data)
    expect(merchant[:data]).to be_a Hash
    expect(merchant[:data].keys).to eq([:id, :type, :attributes])
    expect(merchant[:data][:attributes].keys).to eq([:revenue])
    expect(merchant[:data][:attributes]).to be_a Hash
    expect(merchant[:data][:attributes][:revenue]).to be_a Float
  end
end