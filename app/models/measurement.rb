class Measurement < ApplicationRecord
    belongs_to :user

    validates_presence_of :user
    validates_presence_of :value

    after_create :set_status

    enum status: [:blue, :green, :red]

    private

    def set_status
        status = value < 60 ? 0 : (value < 160 ? 1 : 2) 
        update(status: status)
    end
end
