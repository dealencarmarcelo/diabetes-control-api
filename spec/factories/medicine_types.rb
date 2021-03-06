FactoryBot.define do
  factory :medicine_type do
    name { Faker::Lorem.words(number: 1).first.titleize }
    kind { Faker::Lorem.words(number: 1).first.titleize }
    
    brand factory: :brand
  end
end