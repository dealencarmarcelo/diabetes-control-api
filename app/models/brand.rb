class Brand < ApplicationRecord
    has_many :medicine_types
    
    validates_presence_of :name
end
