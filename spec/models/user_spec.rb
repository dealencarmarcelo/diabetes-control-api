require 'rails_helper'
require 'shoulda/matchers'

describe User, type: :model do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:surname) }

    it { should validate_presence_of(:email) }
    it { should allow_values('example@email.com', 'email@validemail.com.br', 'email-with_symbol.@email.com').for(:email) }
    it { should_not allow_values('email.example.br', 'example@email@test.com').for(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should have_secure_password }
    it { should validate_confirmation_of(:password).on(:create) }

    it { should validate_presence_of(:phone) }
    it { should validate_length_of(:phone).is(11) }
    it { should validate_uniqueness_of(:phone) }

    it { should validate_presence_of(:birth_date) }
    
    it { should validate_presence_of(:diabetes_discovery_date) }
end