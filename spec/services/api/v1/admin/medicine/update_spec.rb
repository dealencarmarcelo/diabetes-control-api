require 'rails_helper'

describe Api::V1::Admin::MedicineType::Update do
  subject(:context) { described_class.call(medicine, update_params) }

  let(:medicine) { create(:medicine) }

  describe '.call' do
    context 'when the context is successful' do
      let(:update_params) do 
        {
            name: Faker::Lorem.words(number: 1).first.titleize,
            content: Faker::Number.between(from: 20, to: 300),
        }
      end
      
      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the context is not successful' do
      let(:update_params) do 
        {
            name: nil,
            content: Faker::Number.between(from: 20, to: 300),
        }
      end

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end