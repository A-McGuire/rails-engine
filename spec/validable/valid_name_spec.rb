require 'rails_helper'
include Validable

RSpec.describe 'valid_name(name)' do
  it 'returns true if the param is a string an not nil' do
    expect(valid_name?("name")).to eq(true)
    expect(valid_name?(0)).to eq(false)
    expect(valid_name?(-1)).to eq(false)
    expect(valid_name?(nil)).to eq(false)
  end
end