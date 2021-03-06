class Api::V1::Admin::Medicine::Create
    prepend SimpleCommand

    def initialize(create_params)
        @create_params = create_params
    end

    def call
        create_medicine
    end

    private

    attr_accessor :create_params

    def create_medicine
        medicine = Medicine.new(create_params)

        return medicine if medicine.save

        errors.add(:base, :failure)

        nil
    end
end