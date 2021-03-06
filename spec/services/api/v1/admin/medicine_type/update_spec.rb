require 'rails_helper'

describe Api::V1::Admin::MedicineType::Update do
  subject(:context) { described_class.call(measurement, update_params) }

  let(:measurement) { create(:measurement) }


  describe '.call' do
    context 'when the context is successful' do
      let(:user_id) { create(:user).id }
      let(:value) { Faker::Number.between(from: 10, to: 500) }

      let(:update_params) do
        { 
          user_id: user_id,
          value: value
        }
      end
      
      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the context is not successful' do
      let(:user_id) { 0 }
      let(:value) { Faker::Number.between(from: 10, to: 500) }

      let(:update_params) do
        { 
          user_id: user_id,
          value: value
        }
      end

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end