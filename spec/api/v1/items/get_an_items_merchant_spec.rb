require 'rails_helper'

RSpec.describe 'merchants show' do

  it 'can get one merchants items w/ attrs' do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    items_merchant = JSON.parse(response.body, symbolize_names: true)
    expect(items_merchant).to be_a Hash
    expect(items_merchant).to have_key(:data)
    expect(items_merchant[:data]).to be_a Hash
    expect(items_merchant[:data].count).to eq(3)
    expect(items_merchant[:data]).to have_key(:id)
    expect(items_merchant[:data][:id]).to be_a String
    expect(items_merchant[:data]).to have_key(:type)
    expect(items_merchant[:data][:type]).to be_a String
    expect(items_merchant[:data]).to have_key(:attributes)
    expect(items_merchant[:data][:attributes]).to be_a Hash
    expect(items_merchant[:data][:attributes][:name]).to be_a String
  end
end