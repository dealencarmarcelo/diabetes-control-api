class Measurement < ApplicationRecord
    validates_presence_of :value, :status

    belongs_to :user
end
