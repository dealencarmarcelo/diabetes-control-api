class Stock < ApplicationRecord
    belongs_to :user
    belongs_to :stockable, polymorphic: :true
    has_many :consumptions

    validates_presence_of :quantity
end
