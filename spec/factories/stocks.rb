FactoryBot.define do
  factory :stock do
    user factory: :user

    association :stockable, factory: :medicine
  end
end