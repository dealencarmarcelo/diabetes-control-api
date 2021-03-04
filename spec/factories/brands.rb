FactoryBot.define do
  factory :brand do
    name { Faker::Lorem.words(number: 1).first.titleize }
  end
end