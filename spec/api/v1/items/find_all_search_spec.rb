require 'rails_helper'

RSpec.describe 'Finds items' do
  it 'returns items matching the partial name query param' do

    3.times do
      create(:item)
    end

    get '/api/v1/items/find?name=it'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a Hash
    expect(merchant).to have_key(:data)
    expect(merchant[:data]).to be_an Array
    expect(merchant[:data].first.keys).to eq([:id, :type, :attributes])
    expect(merchant[:data].first[:id]).to be_a String
    expect(merchant[:data].first[:type]).to be_a String
    expect(merchant[:data].first[:attributes]).to be_a Hash
    expect(merchant[:data].first[:attributes][:name]).to be_a String
  end

  describe 'sad path' do
    it 'requires a query string param' do
      get '/api/v1/merchants/find'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'returns an object even if no match is found' do
      get '/api/v1/merchants/find?name=z'
      
      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to be_a Hash
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a Hash
    end
  end
end