require 'rails_helper'

RSpec.describe 'Revenue for date range' do
  it 'can return the revenue for a range' do
    customer = Customer.create!(first_name: "Cust", last_name: "Tomer")
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id, status: 'shipped')
    invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id, status: 'shipped')
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)

    transaction1 = create(:transaction, invoice: invoice1, result: 'success', created_at: '2012-03-09') #200
    transaction2 = create(:transaction, invoice: invoice2, result: 'success', created_at: '2012-03-10') #100
    transaction3 = create(:transaction, invoice: invoice2, result: 'success', created_at: '2012-03-08') #outside date range, not counted
    transaction4 = create(:transaction, invoice: invoice2, result: 'failed', created_at: '2012-03-10') #failed, no counted

    2.times do
      create(:invoice_item, item: item1, invoice: invoice1) #unit_price 10, quantity 10, revenue => 200
    end

    create(:invoice_item, item: item2, invoice: invoice2)#unit_price 10, quantity 10, revenue => 100

    get '/api/v1/revenue?start=2012-03-09&end=2012-03-24'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    revenue = JSON.parse(response.body, symbolize_names: true)
    
    expect(revenue).to be_a Hash
    expect(revenue).to have_key(:data)
    expect(revenue[:data]).to be_a Hash
    expect(revenue[:data].keys).to eq([:id, :type, :attributes])
    expect(revenue[:data][:id]).to be nil
    expect(revenue[:data][:type]).to be_a String
    expect(revenue[:data][:attributes]).to be_a Hash
    expect(revenue[:data][:attributes].keys).to eq([:revenue])
    expect(revenue[:data][:attributes][:revenue]).to be_a Float
  end

  describe 'sad path' do
    it 'returns 400 if both params are missing' do
      get '/api/v1/revenue'
      
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'returns 400 if start_time param is missing' do
      get '/api/v1/revenue?end=05-10-2020'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'returns 400 if start_time param is blank' do
      get '/api/v1/revenue?end='

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'returns 400 if end_time param is missing' do
      get '/api/v1/revenue?start=05-10-2020'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'returns 400 if end_time param is blank' do
      get '/api/v1/revenue?start='

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end
  end
end