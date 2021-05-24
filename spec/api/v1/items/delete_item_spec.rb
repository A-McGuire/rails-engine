require 'rails_helper'

RSpec.describe 'delete item' do
  it 'deletes the specified item' do
    create(:item, id: 1)
    delete '/api/v1/items/1'
    
    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Item.all).to eq([])
  end
  
  it 'returns 404 for bad item id' do
    delete '/api/v1/items/999999'
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end

  skip 'destroys the invoice if this was the only item on the invoice' do
    Customer.create!(id: 1, first_name: "Cus", last_name: 'Tomer')
    Merchant.create!(id: 2, name: "Merchant")
    create(:item, id: 3, merchant_id: 2)
    Invoice.create!(id: 4, customer_id: 1, merchant_id: 2, status: 2)
    InvoiceItem.create!(item_id: 3, invoice_id: 4, quantity: 1, unit_price: 10)

    delete '/api/v1/items/3'
    
    expect(response).to be_successful
    expect(response.status).to eq(204)
    
    expect(Invoice.all).to eq([])
    expect(InvoiceItem.all).to eq([])
  end

  it 'does not destoy the invoice if the invoice has more items' do
    Customer.create!(id: 1, first_name: "Cus", last_name: 'Tomer')
    Merchant.create!(id: 2, name: "Merchant")
    create(:item, id: 3, merchant_id: 2)
    create(:item, id: 5, merchant_id: 2)
    invoice = Invoice.create!(id: 4, customer_id: 1, merchant_id: 2, status: 2)
    invoice_item1 = InvoiceItem.create!(item_id: 3, invoice_id: 4, quantity: 1, unit_price: 10)
    invoice_item2 = InvoiceItem.create!(item_id: 5, invoice_id: 4, quantity: 1, unit_price: 10)

    delete '/api/v1/items/3'
    
    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Item.where(id: 3).empty?).to eq(true)
    expect(Invoice.all).to eq([invoice])
    expect(InvoiceItem.all).to eq([invoice_item2])
  end
end