class MedicineType < ApplicationRecord
    belongs_to :brand
    has_many :medicines

    validates_presence_of :name, :kind
end
