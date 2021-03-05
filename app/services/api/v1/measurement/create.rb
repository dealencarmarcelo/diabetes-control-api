class Api::V1::Measurement::Create
    prepend SimpleCommand

    def initialize(create_params)
        @user_id = create_params[:user_id]
        @value = create_params[:value]
    end

    def call
        create_measurement
    end

    private

    attr_accessor :user_id, :value

    def create_measurement
        measurement = Measurement.new(user_id: user_id, value: value)

        return measurement if measurement.save

        errors.add(:base, :failure)

        nil
    end
end