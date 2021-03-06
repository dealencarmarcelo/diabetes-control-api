require 'rails_helper'
require 'shoulda/matchers'

describe Api::V1::Admin::MedicineTypesController do
    
    let(:brand) { create(:brand) }
    let(:medicine_type) { create(:medicine_type) }

    let(:params) do 
        {
            name: Faker::Lorem.words(number: 1).first.titleize,
            kind: Faker::Lorem.words(number: 1).first.titleize,
            brand_id: brand.id
        }
    end

    let(:invalid_params) do 
        {
            name: nil,
            kind: Faker::Lorem.words(number: 1).first.titleize,
            brand_id: brand.id
        }
    end

    describe 'get medicine_types' do
        before { get api_v1_admin_medicine_types_path }

        it { expect(response).to have_http_status(:success) }
    end

    describe 'get /medicine_types/:id' do
        context 'when medicine_type exists' do
            before { get api_v1_admin_medicine_type_path(medicine_type.id) }

            it { expect(response).to have_http_status(:success) }

            it 'name and kind be_kind_of String' do
                expect(json['name']).to be_kind_of(String)
                expect(json['kind']).to be_kind_of(String)
            end
        end
        
        context 'when medicine_type does not exists' do
            before { get api_v1_admin_medicine_type_path(0) }

            it { expect(response).to have_http_status(:not_found) }

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find MedicineType/)
            end
        end
    end

    describe 'post /medicine_types' do
        let(:created_medicine_type) { MedicineType.last }
        context 'when name and kind is valid' do
            let(:json) { JSON.parse(response.body, symbolize_names: true) }

            before { post api_v1_admin_medicine_types_path, params: params }

            it { expect(response).to have_http_status(:created) }
            it { expect(created_medicine_type.name).to eq(json.dig(:name)) }
            it { expect(created_medicine_type.kind).to eq(json.dig(:kind)) }
            it { expect(created_medicine_type.brand_id).to eq(json.dig(:brand_id)) }
        end

        context 'when an attribute is invalid' do
            it 'returns unprocessable_entity with nil name' do
                post api_v1_admin_medicine_types_path, params: invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context 'do not create a medicine type' do
            it 'returns no method error' do
                expect { created_medicine_type.name }.to raise_error(NoMethodError)
            end
        end
    end

    describe 'put /medicine_types/:id' do
        context 'when medicine_type exists' do
            it 'returns success with valid name and kind' do
                put api_v1_admin_medicine_type_path(medicine_type.id), params: params
                expect(response).to have_http_status(:success)
            end

            it 'returns unprocessable_entity with invalid name' do
                put api_v1_admin_medicine_type_path(medicine_type.id), params: { name: nil }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid kind' do
                put api_v1_admin_medicine_type_path(medicine_type.id), params: { kind: nil }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid brand_id' do
                put api_v1_admin_medicine_type_path(medicine_type.id), params: { brand_id: nil }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context 'when medicine_type does not exists' do
            it 'raises RecordNotFound when not found' do
                expect { put api_v1_admin_medicine_type_path(MedicineType.find(0)), params: params }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end

    describe 'delete /medicine_types/:id' do
        context 'when medicine_type exists' do
            it 'returns no_content' do
                delete api_v1_admin_medicine_type_path(medicine_type.id)

                expect(response).to have_http_status(:no_content)
            end
        end
        context 'when medicine_type does not exist' do
            it 'raises RecordNotFound when not found' do
                
                expect { delete api_v1_admin_medicine_type_path(MedicineType.find(0)) }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end