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

  it 'returns 404 if an invalid merchant id is given' do
    create(:merchant)

    get '/api/v1/merchants/9999999'

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    expect(response.body).to eq("Couldn't find Merchant with 'id'=9999999")
  end
end
