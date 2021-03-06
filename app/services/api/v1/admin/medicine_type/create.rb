class Api::V1::Admin::MedicineType::Create
    prepend SimpleCommand

    def initialize(create_params)
        @create_params = create_params
    end

    def call
        create_medicine_type
    end

    private

    attr_accessor :create_params

    def create_medicine_type
        medicine_type = MedicineType.new(create_params)

        return medicine_type if medicine_type.save

        errors.add(:base, :failure)

        nil
    end
end