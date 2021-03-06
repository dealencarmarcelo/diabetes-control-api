class Api::V1::Admin::MedicineTypesController < ApplicationController
    before_action :set_medicine_type, only: [:show, :update, :destroy]

    def index
        medicine_types = MedicineType.order(:created_at)
        render json: medicine_types
    end

    def show
        render json: @medicine_type
    end

    def create
        result = Api::V1::Admin::MedicineType::Create.call(medicine_type_params)
        
        if result.success?
            render json: result.result, status: :created
        else
            render json: result.errors, status: :unprocessable_entity
        end
    end

    def update
        result = Api::V1::Admin::MedicineType::Update.call(@medicine_type, medicine_type_params)

        if result.success?
            render json: result.result, status: :ok
        else
            render json: result.errors, status: :unprocessable_entity
        end

    end

    def destroy
        @medicine_type.destroy
    end

    private

    def medicine_type_params
        params.permit(
            :name, 
            :kind
        )
    end

    def set_medicine_type
        @medicine_type = MedicineType.find(params[:id])
    end

    def render_data

    end
end