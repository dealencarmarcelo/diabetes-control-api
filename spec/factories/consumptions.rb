FactoryBot.define do
  factory :consumption do
    stock factory: :stock
    quantity { Faker::Number.between(from: 1, to: 20) }
  end
end