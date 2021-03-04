FactoryBot.define do
  factory :medicine_type do
    name { Faker::Lorem.words(number: 1).first.titleize }
    type { Faker::Lorem.words(number: 1).first.titleize }
  end
end