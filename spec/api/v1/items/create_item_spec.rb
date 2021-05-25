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
    # commented out because controller deletes item after creation for spec harness
    # see last line of items controller
    expect(Item.find_by(name: "value1").present?).to eq(true)
    
    item_test = Item.find_by(name: "value1")
    expect(item_test.description).to eq("value2")
    expect(item_test.unit_price).to eq(100.99)
    expect(item_test.merchant_id).to eq(14)
    
    item = JSON.parse(response.body, symbolize_names: true)
    
    expect(item).to be_a Hash
    expect(item).to have_key(:data)
    expect(item[:data]).to be_a Hash
    expect(item[:data].count).to eq(3)
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a String
    expect(item[:data]).to have_key(:type)
    expect(item[:data][:type]).to be_a String
    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes]).to be_a Hash

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a String

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a String

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a Float

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a Integer
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