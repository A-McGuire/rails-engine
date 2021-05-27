require 'rails_helper'

RSpec.describe 'find one merchant search' do
  it 'returns one merchant' do
    merchant1 = create(:merchant, name: "bbb")
    merchant2 = create(:merchant, name: "aaa")

    expect(Merchant.find_one('bbb')).to eq(merchant1)
  end

  it 'if multiple objs match it returns in aplabetical order' do
    merchant1 = create(:merchant, name: "aab")
    merchant2 = create(:merchant, name: "aaa")

    expect(Merchant.find_one('a')).to eq(merchant2)
  end

  it 'can handle capitals' do
    merchant1 = create(:merchant, name: "aab")
    merchant2 = create(:merchant, name: "aaa")

    expect(Merchant.find_one('A')).to eq(merchant2)
  end
end