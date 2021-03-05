require 'rails_helper'
require 'shoulda/matchers'

describe Api::V1::UsersController do

    let(:password) { Faker::Alphanumeric.alphanumeric(number: 10) }

    let(:params) do
        {
            user: {
                first_name: Faker::Name.first_name,
                surname: Faker::Name.middle_name,
                email: Faker::Internet.email,
                password: password,
                password_confirmation: password,
                phone: Faker::Number.number(digits: 11),
                birth_date: Faker::Date.between(from: (Date.today - 90.years), to: (Date.today - 18.years)).to_date,
                diabetes_discovery_date: Faker::Date.between(from: user.birth_date, to: Date.today)
            }
        }
    end

    let(:user) { create(:user) }
    
    describe 'get /users' do
        before { get api_v1_users_path }

        it { expect(response).to have_http_status(:success) }
    end

    describe 'get /users/:id' do
        context 'when user exists' do
            before { get api_v1_user_path(user.id) }

            it { expect(response).to have_http_status(:success) }

            it 'first_name, surmane, phone and email be_kind_of String' do
                expect(json['first_name']).to be_kind_of(String)
                expect(json['surname']).to be_kind_of(String)
                expect(json['email']).to be_kind_of(String)
                expect(json['phone']).to be_kind_of(String)
            end

            # it 'birth_date and diabetes_discovery_date be_kind_of Date' do
            #     expect(json['birth_date']).to be_kind_of(Date)
            #     expect(json['diabetes_discovery_date']).to be_kind_of(Date)
            # end
        end

        context 'when user does not exist' do
            before { get api_v1_user_path(0) }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end

    describe 'post /users' do
        let(:created_user) { User.last }

        context 'when first_name, surname and email is valid' do
            let(:json) { JSON.parse(response.body, symbolize_names: true) }

            before { post api_v1_users_path, params: params }

            it { expect(response).to have_http_status(:created) }
            it { expect(created_user.first_name).to eq(json.dig(:first_name)) }
        end

        context 'when first_name, surname, phone and email is invalid' do
            it 'returns unprocessable_entity with invalid first_name' do
                post api_v1_users_path, params: { user: { first_name: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid surname' do
                post api_v1_users_path, params: { user: { surname: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid email' do
                post api_v1_users_path, params: { user: { email: 'email_without_format.com' } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with nil email' do
                post api_v1_users_path, params: { user: { email: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with nil phone' do
                post api_v1_users_path, params: { user: { phone: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid phone' do
                post api_v1_users_path, params: { user: { phone: Faker::Number.number(digits: 9) } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid birth_date' do
                post api_v1_users_path, params: { user: { birth_date: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid diabetes_delivery_date' do
                post api_v1_users_path, params: { user: { diabetes_delivery_date: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'do not create an user' do
                expect { created_user.name }.to raise_error(NoMethodError)
            end
        end
    end

    describe 'put /users/:id' do
        context 'when user exists' do
            let(:small_password) { Faker::Alphanumeric.alphanumeric(number: 5) }

            it 'returns success with valid first_name' do
                put api_v1_user_path(user.id), params: { user: { first_name: Faker::Name.first_name } }
                expect(response).to have_http_status(:success)
            end

            it 'returns success with valid surname' do
                put api_v1_user_path(user.id), params: { user: { surname: Faker::Name.middle_name } }
                expect(response).to have_http_status(:success)
            end

            it 'returns success with valid email' do
                put api_v1_user_path(user.id), params: { user: { email: Faker::Internet.email } }
                expect(response).to have_http_status(:success)
            end

            it 'returns success with valid and equals password and password_confirmation' do
                put api_v1_user_path(user.id), params: { user: { password: password, password_confirmation: password } }
                expect(response).to have_http_status(:success)
            end
            
            it 'returns unprocessable_entity with invalid first_name' do
                put api_v1_user_path(user.id), params: { user: { first_name: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid surname' do
                put api_v1_user_path(user.id), params: { user: { surname: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with invalid email' do
                put api_v1_user_path(user.id), params: { user: { email: 'email_without_format.com' } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with nil email' do
                put api_v1_user_path(user.id), params: { user: { email: nil } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with different password and password_confirmation' do
                put api_v1_user_path(user.id), params: { user: { password: password, password_confirmation: Faker::Number.number(digits: 11) } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with password and password_confirmation less than 6 digits' do
                put api_v1_user_path(user.id), params: { user: { password: small_password, password_confirmation: small_password } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with phone less than 11 digits' do
                put api_v1_user_path(user.id), params: { user: { phone: Faker::Number.number(digits: 6) } }
                expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns unprocessable_entity with phone greater than 11 digits' do
                put api_v1_user_path(user.id), params: { user: { phone: Faker::Number.number(digits: 14) } }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context 'when user does not exists' do
            it 'raises RecordNotFound when not found' do
                expect { put api_v1_user_path(User.find(0)), params: params }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end

    describe 'delete /users/:id' do
        context 'when user exists' do
            it 'returns no_content' do
                delete api_v1_user_path(user.id)

                expect(response).to have_http_status(:no_content)
            end
        end
        context 'when user does not exist' do
            it 'raises RecordNotFound when not found' do
                
                expect { delete api_v1_user_path(User.find(0)) }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end