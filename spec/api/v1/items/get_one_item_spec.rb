require 'rails_helper'

RSpec.describe 'items show' do

  it 'can get one item w/ attrs' do
    create(:item, id: 1)
    
    get '/api/v1/items/1'
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item).to be_a Hash
    expect(item).to have_key(:data)
    expect(item[:data]).to be_a Hash
    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes]).to be_a Hash
    expect(item[:data][:attributes][:name]).to be_a String
  end

  it 'returns 404 if an invalid item id is given' do
    create(:item)

    get '/api/v1/items/9999999'

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    expect(response.body).to eq("Couldn't find Item with 'id'=9999999")
  end
end
