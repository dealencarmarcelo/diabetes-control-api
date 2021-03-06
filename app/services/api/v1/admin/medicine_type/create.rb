class Api::V1::Admin::MedicineType::Create
    prepend SimpleCommand

    def initialize(create_params)
        @name = create_params[:name]
        @kind = create_params[:kind]
    end

    def call
        create_measurement
    end

    private

    attr_accessor :name, :kind

    def create_measurement
        measurement = MedicineType.new(name: name, kind: kind)

        return measurement if measurement.save

        errors.add(:base, :failure)

        nil
    end
end