require 'rails_helper'

RSpec.describe 'items index' do
  it 'can get all items & item attrs' do
    50.times do
      create(:item)
    end

    get '/api/v1/items'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to be_a Hash
    expect(items).to have_key(:data)
    expect(items[:data]).to be_an Array
    expect(items[:data].count).to eq(20)
    expect(items[:data].first).to be_a Hash
    expect(items[:data].first).to have_key(:attributes)
    expect(items[:data].first[:attributes]).to be_a Hash
    expect(items[:data].first[:attributes][:name]).to be_a String
    expect(items[:data].first[:attributes][:description]).to be_a String
    expect(items[:data].first[:attributes][:unit_price]).to be_a Float
    expect(items[:data].first[:attributes][:merchant_id]).to be_a Integer
  end
end