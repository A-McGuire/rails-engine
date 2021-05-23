require 'rails_helper'

RSpec.describe 'Create and then delete an item' do
  it 'creates an item' do
    post '/api/v1/items'
    binding.pry
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    items = JSON.parse(response.body, symbolize_names: true)
  end
end