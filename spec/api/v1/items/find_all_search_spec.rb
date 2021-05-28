require 'rails_helper'

RSpec.describe 'Finds items' do
  describe 'find all items by name' do
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
      expect(items[:data].count).to eq(3)
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

  describe 'Find all items by min and/or max' do
    it 'can accept both params' do
      create(:item, unit_price: 1)
      create(:item, unit_price: 10)
      create(:item, unit_price: 20)
      create(:item, unit_price: 30)

      get '/api/v1/items/find_all?min_price=10&max_price=30'
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      items = JSON.parse(response.body, symbolize_names: true)
  
      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_an Array
      expect(items[:data].count).to eq(3)
      expect(items[:data].first.keys).to eq([:id, :type, :attributes])
      expect(items[:data].first[:id]).to be_a String
      expect(items[:data].first[:type]).to be_a String
      expect(items[:data].first[:attributes]).to be_a Hash
      expect(items[:data].first[:attributes][:name]).to be_a String
    end

    it 'can accept the min_price param' do
      create(:item, unit_price: 1)
      create(:item, unit_price: 10)
      create(:item, unit_price: 20)
      create(:item, unit_price: 30)

      get '/api/v1/items/find_all?min_price=10'
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      items = JSON.parse(response.body, symbolize_names: true)
  
      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_an Array
      expect(items[:data].count).to eq(3)
      expect(items[:data].first.keys).to eq([:id, :type, :attributes])
      expect(items[:data].first[:id]).to be_a String
      expect(items[:data].first[:type]).to be_a String
      expect(items[:data].first[:attributes]).to be_a Hash
      expect(items[:data].first[:attributes][:name]).to be_a String
    end

    it 'can accept the max_price param' do
      create(:item, unit_price: 1)
      create(:item, unit_price: 10)
      create(:item, unit_price: 20)
      create(:item, unit_price: 30)
      create(:item, unit_price: 40)

      get '/api/v1/items/find_all?max_price=30'
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      items = JSON.parse(response.body, symbolize_names: true)
  
      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_an Array
      expect(items[:data].count).to eq(4)
      expect(items[:data].first.keys).to eq([:id, :type, :attributes])
      expect(items[:data].first[:id]).to be_a String
      expect(items[:data].first[:type]).to be_a String
      expect(items[:data].first[:attributes]).to be_a Hash
      expect(items[:data].first[:attributes][:name]).to be_a String
    end

    describe 'sad path' do
      it 'returns an object even if no match is found min_price' do

        create(:item, unit_price: 4)
        
        get '/api/v1/items/find_all?min_price=5'
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
  
        items = JSON.parse(response.body, symbolize_names: true)
  
        expect(items).to be_a Hash
        expect(items).to have_key(:data)
        expect(items[:data]).to be_an Array
      end

      it 'returns an object even if no match is found max_price' do

        create(:item, unit_price: 6)
        
        get '/api/v1/items/find_all?max_price=5'
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
  
        items = JSON.parse(response.body, symbolize_names: true)
  
        expect(items).to be_a Hash
        expect(items).to have_key(:data)
        expect(items[:data]).to be_an Array
      end
    end
  end
end