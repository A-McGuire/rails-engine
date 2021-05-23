require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    FactoryBot.reload
  end

  describe '.all_merchants(page_number = 1, per_page = 20)' do
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
      expect(Merchant.all_merchants.first.name).to eq('merchant1')
      expect(Merchant.all_merchants.last.name).to eq('merchant20')
    end
    
    it 'returns the first page if the page number is less than 1' do
      25.times do
        create(:merchant)
      end

      expect(Merchant.all_merchants(-1).count).to eq(20)
      expect(Merchant.all_merchants.first.name).to eq('merchant1')
      expect(Merchant.all_merchants.last.name).to eq('merchant20')
    end

    it 'can specify the number of merchants per page' do
      25.times do
        create(:merchant)
      end

      expect(Merchant.all_merchants(page_number = 1, per_page = 25).count).to eq(25)
      expect(Merchant.all_merchants(page_number = 1, per_page = 25).first.name).to eq('merchant1')
      expect(Merchant.all_merchants(page_number = 1, per_page = 25).last.name).to eq('merchant25')
    end
  end
end