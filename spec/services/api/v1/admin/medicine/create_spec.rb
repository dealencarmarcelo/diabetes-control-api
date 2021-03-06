require 'rails_helper'

describe Api::V1::Admin::Medicine::Create do
  subject(:context) { described_class.call(create_params) }

  let(:medicine_type) { create(:medicine_type) }

  describe '.call' do
    context 'when the context is successful' do
      let(:create_params) do 
        {
            name: Faker::Lorem.words(number: 1).first.titleize,
            medicine_type_id: medicine_type.id,
            content: Faker::Number.between(from: 20, to: 300),
            unit: Faker::Lorem.words(number: 1).first,
        }
    end
      
      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the context is not successful' do
      let(:create_params) do 
        {
            name: nil,
            medicine_type_id: medicine_type.id,
            content: Faker::Number.between(from: 20, to: 300),
            unit: Faker::Lorem.words(number: 1).first,
        }
      end

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end