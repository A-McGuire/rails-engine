require 'rails_helper'

RSpec.describe 'merchants show' do
  it 'can get one merchant w/ attrs' do
    create(:merchant)
    
    get '/api/v1/merchants/1'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a Hash
    expect(merchant).to have_key(:data)
    expect(merchant[:data]).to be_a Hash
    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data][:attributes]).to be_a Hash
    expect(merchant[:data][:attributes][:name]).to be_a String
  end
end
