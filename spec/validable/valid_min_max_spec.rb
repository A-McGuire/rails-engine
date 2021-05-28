require 'rails_helper'
include Validable
RSpec.describe 'valid_min_max(min, max)' do
  it 'returns true if both params are present and an integer > 0' do
    expect(valid_min_max?(1, 2)).to eq(true)
    expect(valid_min_max?(nil, 1)).to eq(true)
    expect(valid_min_max?(1, nil)).to eq(true)
    expect(valid_min_max?(nil, nil)).to eq(false)
  end
end