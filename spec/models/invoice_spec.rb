require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
    it {should belong_to :customer}
  end
  
  describe 'class methods' do
    describe '.find_empty' do
      it 'returns invoices that have no invoice items' do
        Customer.create!(id: 1, first_name: "Cus", last_name: 'Tomer')
        Merchant.create!(id: 2, name: "Merchant")
        create(:item, id: 3, merchant_id: 2)
        create(:item, id: 6, merchant_id: 2)
        invoice1 = Invoice.create!(id: 4, customer_id: 1, merchant_id: 2, status: 2)
        InvoiceItem.create!(item_id: 3, invoice_id: 4, quantity: 1, unit_price: 10)
        
        invoice2 = Invoice.create!(id: 5, customer_id: 1, merchant_id: 2, status: 2)

        expect(Invoice.find_empty).to eq([invoice2])
      end
    end
  end
end
