require 'rails_helper'

RSpec.describe 'merchants index' do
  it 'can get all merchants & merchant attrs' do
    40.times do
      create(:merchant)
    end
    get '/api/v1/merchants'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].count).to eq(20)
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can take query parameter: page' do
    40.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {page: 1}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(20)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can take query parameter: {page: 2} and return page 2' do
    39.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {page: 2}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(19)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can take query parameter: {page: 0} and return page 1' do
    39.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {page: 0}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(20)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can take query parameter: {page: -1} and return page 1' do
    39.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {page: -1}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(20)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can take query parameter: {page: 400} and return nothing' do
    39.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {page: 400}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(0)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to eq(nil)
  end

  it 'can take query parameter {per_page: 10} and return 10 results per page' do
    40.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {per_page: 10}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(10)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can take query parameter {per_page: 50} and return 50 results per page' do
    55.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {per_page: 50}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(50)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can take query parameter {per_page: 100} and return all results on one page' do
    55.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {per_page: 100}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(55)
    expect(merchants[:data].count).to eq(Merchant.all.count)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can take both query parameters' do
    15.times do
      create(:merchant)
    end
    get '/api/v1/merchants', params: {per_page: 10, page: 2}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a Hash
    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(5)
    expect(merchants[:data]).to be_an Array
    expect(merchants[:data].first).to be_a Hash
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to be_a Hash
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end
end