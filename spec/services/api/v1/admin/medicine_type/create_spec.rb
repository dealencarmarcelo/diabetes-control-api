require 'rails_helper'

describe Api::V1::Admin::MedicineType::Create do
  subject(:context) { described_class.call(create_params) }

  describe '.call' do
    context 'when the context is successful' do
      let(:name) { Faker::Lorem.words(number: 1).first.titleize }
      let(:kind) { Faker::Lorem.words(number: 1).first.titleize }

      let(:create_params) do
        { 
          name: name,
          kind: kind
        }
      end
      
      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the context is not successful' do
      let(:name) { nil }
      let(:kind) { Faker::Lorem.words(number: 1).first.titleize }

      let(:create_params) do
        { 
          name: name,
          kind: kind
        }
      end

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end