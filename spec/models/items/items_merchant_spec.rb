require 'rails_helper'

RSpec.describe '.items_merchant(item_id)' do
  it 'returns the merchant for the given item' do
    Merchant.create!(id: 1, name: 'merchant1')
    Merchant.create!(id: 2, name: 'merchant2')
    Merchant.create!(id: 3, name: 'merchant3')
    item = create(:item, merchant_id: 1)

    expect(Item.items_merchant(item.id).id).to eq(1)
    expect(Item.items_merchant(item.id).name).to eq('merchant1')
  end
end