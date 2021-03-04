FactoryBot.define do
  factory :stock do
    user factory: :user
    quantity { Faker::Number.between(from: 1, to: 500) }

    association :stockable, factory: :medicine
  end
end