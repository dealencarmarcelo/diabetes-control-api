class Api::V1::Admin::Medicine::Update
    prepend SimpleCommand

    def initialize(medicine, update_params)
        @medicine = medicine
        @update_params = update_params
    end

    def call
        update_medicine
    end

    private

    attr_accessor :medicine, :update_params

    def update_medicine

        return medicine if medicine.update(update_params)

        errors.add(:base, :failure)

        nil
    end
end