require 'rails_helper'

RSpec.describe 'find all items by min max search' do
  before :each do
    FactoryBot.reload
  end
  
  it 'returns items within the params given' do
    item1 = create(:item, unit_price: 10)
    item2 = create(:item, unit_price: 20)
    item3 = create(:item, unit_price: 30)
    item4 = create(:item, unit_price: 40)

    expect(Item.find_by_min_max(11, 39)).to eq([item2, item3])
  end

  it 'returns no items if no items meet the search criteria' do
    item1 = create(:item, unit_price: 10)
    item2 = create(:item, unit_price: 20)
    item3 = create(:item, unit_price: 30)
    item4 = create(:item, unit_price: 40)

    expect(Item.find_by_min_max(41, 50)).to eq([])
  end

  it 'returns all items if all items meet the search criteria' do
    item1 = create(:item, unit_price: 10)
    item2 = create(:item, unit_price: 20)
    item3 = create(:item, unit_price: 30)
    item4 = create(:item, unit_price: 40)

    expect(Item.find_by_min_max(10, 40)).to eq([item1, item2, item3, item4])
  end
end