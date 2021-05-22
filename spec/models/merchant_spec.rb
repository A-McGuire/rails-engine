require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    describe '.all_merchants' do
      it 'returns all merchants, 20 at a time' do
        merchant1 = Merchant.create!(name: '1')
        merchant2 = Merchant.create!(name: '1')
        merchant3 = Merchant.create!(name: '1')
        merchant4 = Merchant.create!(name: '1')
        merchant5 = Merchant.create!(name: '1')
        merchant6 = Merchant.create!(name: '1')
        merchant7 = Merchant.create!(name: '1')
        merchant8 = Merchant.create!(name: '1')
        merchant9 = Merchant.create!(name: '1')
        merchant10 = Merchant.create!(name: '1')
        merchant11 = Merchant.create!(name: '1')
        merchant12 = Merchant.create!(name: '1')
        merchant13 = Merchant.create!(name: '1')
        merchant14 = Merchant.create!(name: '1')
        merchant15 = Merchant.create!(name: '1')
        merchant16 = Merchant.create!(name: '1')
        merchant17 = Merchant.create!(name: '1')
        merchant18 = Merchant.create!(name: '1')
        merchant19 = Merchant.create!(name: '1')
        merchant20 = Merchant.create!(name: '1')
        merchant21 = Merchant.create!(name: '1')

        expect(Merchant.all_merchants(2)).to eq([merchant21])
        expect(Merchant.all_merchants(1)).to eq([merchant1])
      end
    end
  end
end
