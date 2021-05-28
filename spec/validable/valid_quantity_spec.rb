require 'rails_helper'
include Validable

RSpec.describe 'valid_quantity(quanity)' do
  it 'returns true if the param is an integer and greater than 0' do
    expect(valid_quantity?(1)).to eq(true)
    expect(valid_quantity?(0)).to eq(false)
    expect(valid_quantity?(-1)).to eq(false)
    expect(valid_quantity?('abc')).to eq(false)
    expect(valid_quantity?(nil)).to eq(false)
  end
end