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
        22.times do
          create(:merchant)
        end

        expect(Merchant.all_merchants(1).count).to eq(20)
        expect(Merchant.all_merchants(1).first.id).to eq(1)
        expect(Merchant.all_merchants(1).last.id).to eq(20)

        expect(Merchant.all_merchants(2).count).to eq(2)
        expect(Merchant.all_merchants(2).first.id).to eq(21)
        expect(Merchant.all_merchants(2).last.id).to eq(22)
      end
    end
  end
end
