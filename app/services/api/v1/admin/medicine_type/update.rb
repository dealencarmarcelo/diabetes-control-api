class Api::V1::Admin::MedicineType::Update
    prepend SimpleCommand

    def initialize(medicine_type, update_params)
        @medicine_type = medicine_type
        @update_params = update_params
    end

    def call
        update_medicine_type
    end

    private

    attr_accessor :medicine_type, :update_params

    def update_medicine_type

        return medicine_type if medicine_type.update(update_params)

        errors.add(:base, :failure)

        nil
    end
end