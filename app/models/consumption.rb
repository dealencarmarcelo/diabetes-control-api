class Consumption < ApplicationRecord
    belongs_to :stock

    validates_presence_of :quantity
end
