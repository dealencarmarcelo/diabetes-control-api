FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    surname { Faker::Name.middle_name }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 10) }

    # Using 11 digits on phone number to set format 99999999999 (pt-BR cell phone without +55)
    phone { Faker::Number.number(digits: 11) }
    
    birth_date { Faker::Date.between(from: (Date.today - 90.years), to: (Date.today - 18.years)) }
    diabetes_discovery_date { Faker::Date.between(from: birth_date, to: Date.today) }
  end
end