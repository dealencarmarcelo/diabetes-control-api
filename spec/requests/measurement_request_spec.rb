require 'rails_helper'
require 'shoulda/matchers'

describe Api::V1::MeasurementsController do
    let(:user) { create(:user) }
    let(:measurement) { create(:measurement, user: user) }

    let(:params) do 
        {
            user_id: user.id,
            value: Faker::Number.between(from: 10, to: 500)
        }
    end

    describe 'get user/:id/measurements' do
        before { get api_v1_user_measurements_path(user.id) }

        it { expect(response).to have_http_status(:success) }
    end

    describe 'get /users/:id/measurements/:measurement_id' do
        context 'when measurement exists' do
            before { get api_v1_user_measurement_path(user.id, measurement.id) }

            it { expect(response).to have_http_status(:success) }

            it 'value be_kind_of Integer' do
                expect(json['value']).to be_kind_of(Integer)
            end
        end
        
        context 'when measurement does not exists' do
            before { get api_v1_user_measurement_path(user.id, 0) }

            it { expect(response).to have_http_status(:not_found) }

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Measurement/)
            end
        end
    end

    describe 'post /users/:id/measurements' do
        let(:created_measurement) { Measurement.last }
        context 'when value is valid' do
            let(:json) { JSON.parse(response.body, symbolize_names: true) }

            before { post api_v1_user_measurements_path(user.id), params: params }

            it { expect(response).to have_http_status(:created) }
            it { expect(created_measurement.value).to eq(json.dig(:value)) }
        end

        context 'when value invalid' do
            it 'returns unprocessable_entity with nil value' do
                post api_v1_user_measurements_path(user.id), params: { user_id: user.id, value: nil }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'do not create an measurement' do
                expect { created_measurement.name }.to raise_error(NoMethodError)
            end
        end
    end

    describe 'put /users/:id/measurement/:measurement_id' do
        context 'when measurement exists' do
            it 'returns success with valid value' do
                put api_v1_user_measurement_path(user.id, measurement.id), params: { value: Faker::Number.between(from: 10, to: 500) }
                expect(response).to have_http_status(:success)
            end

            it 'returns unprocessable_entity with invalid value' do
                put api_v1_user_measurement_path(user.id, measurement.id), params: { value: nil }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context 'when measurement does not exists' do
            it 'raises RecordNotFound when not found' do
                expect { put api_v1_user_measurement_path(user.id, Measurement.find(0)), params: params }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end

    describe 'delete /users/:id' do
        context 'when user exists' do
            it 'returns no_content' do
                delete api_v1_user_measurement_path(user.id, measurement.id)

                expect(response).to have_http_status(:no_content)
            end
        end
        context 'when user does not exist' do
            it 'raises RecordNotFound when not found' do
                
                expect { delete api_v1_user_measurement_path(user.id, Measurement.find(0)) }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end