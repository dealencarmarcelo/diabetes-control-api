class Api::V1::Admin::MedicinesController < ApplicationController
    before_action :set_medicine, only: [:show, :update, :destroy]

    def index
        medicine = Medicine.order(:name)
        render json: medicine
    end

    def show
        render json: @medicine
    end

    def create
        result = Api::V1::Admin::Medicine::Create.call(medicine_params)
        
        if result.success?
            render json: result.result, status: :created
        else
            render json: result.errors, status: :unprocessable_entity
        end
    end

    def update
        result = Api::V1::Admin::Medicine::Update.call(@medicine, medicine_params)

        if result.success?
            render json: result.result, status: :ok
        else
            render json: result.errors, status: :unprocessable_entity
        end

    end

    def destroy
        @medicine.destroy
    end

    private

    def medicine_params
        params.permit(
            :name, 
            :unit,
            :content,
            :medicine_type_id
        )
    end

    def set_medicine
        @medicine = Medicine.find(params[:id])
    end
end