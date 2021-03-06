require 'rails_helper'
require 'shoulda/matchers'

describe Api::V1::Admin::MedicinesController do
    let(:medicine_type) { create(:medicine_type) }
    let(:medicine) { create(:medicine, medicine_type: medicine_type) }

    let(:params) do 
        {
            name: Faker::Lorem.words(number: 1).first.titleize,
            medicine_type_id: medicine_type.id,
            content: Faker::Number.between(from: 20, to: 300),
            unit: Faker::Lorem.words(number: 1).first,
        }
    end

    let(:invalid_params) do 
        {
            name: nil,
            medicine_type_id: medicine_type.id,
            content: Faker::Number.between(from: 20, to: 300),
            unit: Faker::Lorem.words(number: 1).first,
        }
    end

    describe 'get medicines/:id' do
        before { get api_v1_admin_medicines_path(medicine_type.id) }

        it { expect(response).to have_http_status(:success) }
    end

    describe 'get /medicines/:id' do
        context 'when medicine exists' do
            before { get api_v1_admin_medicine_path(medicine.id) }

            it { expect(response).to have_http_status(:success) }

            it 'name and unit be_kind_of String' do
                expect(json['name']).to be_kind_of(String)
                expect(json['unit']).to be_kind_of(String)
            end

            it 'content be_kind_of Integer' do
                expect(json['content']).to be_kind_of(Integer)
            end
        end
        
        context 'when medicine does not exists' do
            before { get api_v1_admin_medicine_path(0) }

            it { expect(response).to have_http_status(:not_found) }

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Medicine/)
            end
        end
    end

    describe 'post /medicine_types/:id/medicines' do
        let(:created_medicine) { Medicine.last }
        context 'when attributes is valid' do
            let(:json) { JSON.parse(response.body, symbolize_names: true) }

            before { post api_v1_admin_medicines_path, params: params }

            it { expect(response).to have_http_status(:created) }
            it { expect(created_medicine.name).to eq(json.dig(:name)) }
            it { expect(created_medicine.content).to eq(json.dig(:content)) }
            it { expect(created_medicine.unit).to eq(json.dig(:unit)) }
            it { expect(created_medicine.medicine_type_id).to eq(json.dig(:medicine_type_id)) }
        end

        context 'when an attribute is invalid' do
            it 'returns unprocessable_entity with nil value' do
                post api_v1_admin_medicines_path(medicine_type.id), params: invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context 'do not create a medicine' do
            it 'returns no method error' do
                expect { created_medicine.name }.to raise_error(NoMethodError)
            end
        end
    end

    describe 'put /medicine_types/:id/medicine/:medicine_id' do
        context 'when medicine exists' do
            it 'returns success with valid value' do
                put api_v1_admin_medicine_path(medicine.id), params: { value: Faker::Number.between(from: 10, to: 500) }
                expect(response).to have_http_status(:success)
            end

            it 'returns unprocessable_entity with invalid attribute' do
                put api_v1_admin_medicine_path(medicine.id), params: invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context 'when medicine does not exists' do
            it 'raises RecordNotFound when not found' do
                expect { put api_v1_admin_medicine_path(Medicine.find(0)), params: params }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end

    describe 'delete /medicine_types/:id' do
        context 'when medicine_type exists' do
            it 'returns no_content' do
                delete api_v1_admin_medicine_path(medicine.id)

                expect(response).to have_http_status(:no_content)
            end
        end
        context 'when medicine_type does not exist' do
            it 'raises RecordNotFound when not found' do
                
                expect { delete api_v1_admin_medicine_path(Medicine.find(0)) }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end