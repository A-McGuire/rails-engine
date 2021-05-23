require 'rails_helper'

RSpec.describe 'merchants show' do

  it 'can get one merchants items w/ attrs' do
    create(:merchant, id: 1)
    
    10.times do
      create(:item, merchant_id: 1)
    end

    get '/api/v1/merchants/1/items'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchant_items = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_items).to be_a Hash
    expect(merchant_items).to have_key(:data)
    expect(merchant_items[:data]).to be_an Array
    expect(merchant_items[:data].count).to eq(10)
    expect(merchant_items[:data].first).to be_a Hash
    expect(merchant_items[:data].first).to have_key(:attributes)
    expect(merchant_items[:data].first[:attributes]).to be_a Hash
    expect(merchant_items[:data].first[:attributes][:name]).to be_a String
  end

  it 'returns 404 if an invalid merchant id is given' do
    create(:merchant)

    get '/api/v1/merchants/9999999/items'

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    expect(response.body).to eq("Couldn't find Merchant with 'id'=9999999")
  end
end