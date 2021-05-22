require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
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
