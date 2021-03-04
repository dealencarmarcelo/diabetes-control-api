FactoryBot.define do
  factory :medicine do
    name { Faker::Lorem.words(number: 1).first.titleize }
    content { Faker::Number.between(from: 20, to: 300) }
    measurement_unit { Faker::Lorem.words(number: 1).first }

    brand factory: :brand
    medicine_type factory: :medicine_type
  end
end