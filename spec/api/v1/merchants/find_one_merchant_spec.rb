require 'rails_helper'

RSpec.describe 'Find one merchant' do
  it 'returns a single merchant with the name query param' do

    create(:merchant, name: 'merchant1')
    create(:merchant, name: 'merchant2')

    get '/api/v1/merchants/find?name=merchant1'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a Hash
    expect(merchant).to have_key(:data)
    expect(merchant[:data]).to be_a Hash
    expect(merchant[:data].keys).to eq([:id, :type, :attributes])
    expect(merchant[:data][:id]).to be_a String
    expect(merchant[:data][:type]).to be_a String
    expect(merchant[:data][:attributes]).to be_a Hash
    expect(merchant[:data][:attributes][:name]).to be_a String
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