require 'rails_helper'

RSpec.describe 'find all items by min max search' do
  it 'returns items within the params given' do
    item1 = create(:item, unit_price: 10)
    item2 = create(:item, unit_price: 20)
    item3 = create(:item, unit_price: 30)
    item4 = create(:item, unit_price: 40)

    expect(Item.find_by_min_max(15, 35)).to eq([item2, item3])
  end
end