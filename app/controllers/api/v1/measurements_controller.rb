class Api::V1::MeasurementsController < ApplicationController
    before_action :set_measurement, only: [:show, :update, :destroy]

    def index
        measurements = Measurement.order(:created_at)
        render json: measurements
    end

    def show
        render json: @measurement
    end

    def create
        result = Api::V1::Measurement::Create.call(measurement_params)
        
        if result.success?
            render json: result.result, status: :created
        else
            render json: result.errors, status: :unprocessable_entity
        end
    end

    def update
        result = Api::V1::Measurement::Update.call(@measurement, measurement_params)

        if result.success?
            render json: result.result, status: :ok
        else
            render json: result.errors, status: :unprocessable_entity
        end

    end

    def destroy
        @measurement.destroy
    end

    private

    def measurement_params
        params.permit(
            :user_id, 
            :value
        )
    end

    def set_measurement
        @measurement = Measurement.find(params[:id])
    end

    def render_data

    end
end