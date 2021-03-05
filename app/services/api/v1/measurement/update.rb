class Api::V1::Measurement::Update
    prepend SimpleCommand

    def initialize(measurement, update_params)
        @measurement = measurement
        @update_params = update_params
    end

    def call
        update_measurement
    end

    private

    attr_accessor :measurement, :update_params

    def update_measurement

        return @measurement if @measurement.update(@update_params)

        errors.add(:base, :failure)

        nil
    end
end