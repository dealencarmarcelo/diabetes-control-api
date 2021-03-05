require 'rails_helper'

describe Api::V1::Measurement::Create do
  subject(:context) { described_class.call(create_params) }

  describe '.call' do
    context 'when the context is successful' do
      let(:user_id) { create(:user).id }
      let(:value) { Faker::Number.between(from: 10, to: 500) }

      let(:create_params) do
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

      let(:create_params) do
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