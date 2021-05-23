require 'rails_helper'

RSpec.describe 'Create an item' do
  it 'creates an item' do
    merchant = Merchant.create!(id: 14, name: "merchant")
    post '/api/v1/items', params: {"item" => {
                                  "name": "value1",
                                  "description": "value2",
                                  "unit_price": 100.99,
                                  "merchant_id": 14
                                }}
    
    expect(response).to be_successful
    expect(response.status).to eq(201)
    
    items = JSON.parse(response.body, symbolize_names: true)
    
    expect(items).to be_a Hash
    expect(items).to have_key(:data)
    expect(items[:data]).to be_a Hash
    expect(items[:data].count).to eq(3)
    expect(items[:data]).to have_key(:id)
    expect(items[:data][:id]).to be_a String
    expect(items[:data]).to have_key(:type)
    expect(items[:data][:type]).to be_a String
    expect(items[:data]).to have_key(:attributes)
    expect(items[:data][:attributes]).to be_a Hash

    expect(items[:data][:attributes]).to have_key(:name)
    expect(items[:data][:attributes][:name]).to be_a String

    expect(items[:data][:attributes]).to have_key(:description)
    expect(items[:data][:attributes][:description]).to be_a String

    expect(items[:data][:attributes]).to have_key(:unit_price)
    expect(items[:data][:attributes][:unit_price]).to be_a Float

    expect(items[:data][:attributes]).to have_key(:merchant_id)
    expect(items[:data][:attributes][:merchant_id]).to be_a Integer
  end

  it 'returns a 422 if request is missing merchant_id' do
    merchant = Merchant.create!(id: 14, name: "merchant")
    post '/api/v1/items', params: {"item" => {
                                  "name": "value1",
                                  "description": "value2",
                                  "unit_price": 100.99
                                }}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
  end

  it 'returns a 422 if request is missing name' do
    merchant = Merchant.create!(id: 14, name: "merchant")
    post '/api/v1/items', params: {"item" => {
                                  "description": "value2",
                                  "unit_price": 100.99,
                                  "merchant_id": 14
                                }}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
  end

  it 'returns a 422 if request is missing description' do
    merchant = Merchant.create!(id: 14, name: "merchant")
    post '/api/v1/items', params: {"item" => {
                                  "name": "value1",
                                  "unit_price": 100.99,
                                  "merchant_id": 14
                                }}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
  end

  it 'returns a 422 if request is missing unit_price' do
    merchant = Merchant.create!(id: 14, name: "merchant")
    post '/api/v1/items', params: {"item" => {
                                  "name": "value1",
                                  "description": "value2",
                                  "merchant_id": 14
                                }}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
  end
end