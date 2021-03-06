class Medicine < ApplicationRecord
    belongs_to :medicine_type
    has_many :stock, as: :stockable

    validates_presence_of :name, :unit, :content
end
