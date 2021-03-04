FactoryBot.define do
  factory :measurement do
    user factory: :user
    value { Faker::Number.between(from: 10, to: 500) }
    status {
        if value < 60
            return 'blue'
        elsif value < 160
            return 'green'
        else
            return 'red'
        end
     }
  end
end