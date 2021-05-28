require 'rails_helper'
include Validable

RSpec.describe 'valid_start_end_dates(start_time, end_time)' do
  it 'returns true if the params are both present' do
    expect(valid_start_end_dates?('05-10-2020', '05-12-2020')).to eq(true)
    expect(valid_start_end_dates?(nil, '05-12-2020')).to eq(false)
    expect(valid_start_end_dates?('05-10-2020', nil)).to eq(false)
  end
end