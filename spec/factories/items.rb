FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "item#{n}" }
    description { 'very good item' }
    unit_price { 100 }
    merchant_id { 1 }
    merchant
  end
end