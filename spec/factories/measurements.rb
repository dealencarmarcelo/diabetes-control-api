FactoryBot.define do
  factory :measurement do
    user factory: :user
    value { Faker::Number.between(from: 10, to: 500) }
  end
end