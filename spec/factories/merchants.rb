FactoryBot.define do
  factory :merchant do
    sequence(:id)
    name { Faker::DcComics.name}
  end
end