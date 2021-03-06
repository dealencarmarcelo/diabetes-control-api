FactoryBot.define do
  factory :medicine do
    name { Faker::Lorem.words(number: 1).first.titleize }
    content { Faker::Number.between(from: 20, to: 300) }
    unit { Faker::Lorem.words(number: 1).first }

    medicine_type factory: :medicine_type
  end
end