require 'rails_helper'

RSpec.describe 'Finds items' do
  it 'returns items matching the partial name query param' do

    3.times do
      create(:item)
    end

    get '/api/v1/items/find_all?name=it'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to be_a Hash
    expect(items).to have_key(:data)
    expect(items[:data]).to be_an Array
    expect(items[:data].first.keys).to eq([:id, :type, :attributes])
    expect(items[:data].first[:id]).to be_a String
    expect(items[:data].first[:type]).to be_a String
    expect(items[:data].first[:attributes]).to be_a Hash
    expect(items[:data].first[:attributes][:name]).to be_a String
  end

  describe 'sad path' do
    it 'requires a query string param' do
      get '/api/v1/items/find_all'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'returns an object even if no match is found' do
      get '/api/v1/items/find_all?name=z'
      
      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_an Array
    end
  end
end