class MedicineType < ApplicationRecord
    has_many :medicines

    validates_presence_of :name, :type
end
