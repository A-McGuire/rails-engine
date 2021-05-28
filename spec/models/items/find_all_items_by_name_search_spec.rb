require 'rails_helper'

RSpec.describe 'find all items by name search' do
  before :each do
    FactoryBot.reload
  end

  it 'returns single item in array if it is the only match' do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    item4 = create(:item)

    expect(Item.find_all("item1")).to eq([item1])
  end

  it 'returns items with partial search' do
    item3 = create(:item)
    item1 = create(:item)
    item4 = create(:item)
    item2 = create(:item)

    expect(Item.find_all("it")).to eq([item3, item1, item4, item2])
  end
  
  it 'can handle capitals' do
    item3 = create(:item)
    item1 = create(:item)
    item4 = create(:item)
    item2 = create(:item)
  
    expect(Item.find_all("IT")).to eq([item3, item1, item4, item2])
  end
end