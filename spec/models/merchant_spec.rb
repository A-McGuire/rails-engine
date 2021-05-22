require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    describe '.all_merchants(page_number, per_page)' do
      it 'returns all merchants, 20 at a time default' do
        25.times do
          create(:merchant)
        end

        expect(Merchant.all_merchants(1).count).to eq(20)
        expect(Merchant.all_merchants(1).first.name).to eq('merchant1')
        expect(Merchant.all_merchants(1).last.name).to eq('merchant20')

        expect(Merchant.all_merchants(2).count).to eq(5)
        expect(Merchant.all_merchants(2).first.name).to eq('merchant21')
        expect(Merchant.all_merchants(2).last.name).to eq('merchant25')
      end

      it 'returns first page if no page is specified' do
        25.times do
          create(:merchant)
        end

        expect(Merchant.all_merchants.count).to eq(20)
        expect(Merchant.all_merchants.first.name).to eq('merchant26')
        expect(Merchant.all_merchants.last.name).to eq('merchant45')
      end
    end

    describe 'merchant(id)' do
      skip 'returns the merchant with the given id' do
        3.times do
          create(:merchant)
        end

        merchant = Merchant.create!(id: 17, name: 'seventeen')

        expect(Merchant.merchant(2).id).to eq(2)
        expect(Merchant.merchant(3).id).to eq(3)
        expect(Merchant.merchant(1).id).to eq(1)
        
        expect(Merchant.merchant(17).id).to eq(17)
        expect(Merchant.merchant(17).name).to eq('seventeen')
      end
    end
  end
end
