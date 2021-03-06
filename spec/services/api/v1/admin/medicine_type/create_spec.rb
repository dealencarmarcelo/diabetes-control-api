require 'rails_helper'

describe Api::V1::Admin::MedicineType::Create do
  subject(:context) { described_class.call(create_params) }

  let(:brand) { create(:brand) }

  describe '.call' do
    context 'when the context is successful' do
      let(:create_params) do
        { 
          name: Faker::Lorem.words(number: 1).first.titleize,
          kind: Faker::Lorem.words(number: 1).first.titleize,
          brand_id: brand.id
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
          kind: Faker::Lorem.words(number: 1).first.titleize,
          brand_id: brand.id
        }
      end

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end