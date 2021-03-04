require 'rails_helper'

require 'shoulda/matchers'

describe MedicineType, type: :model do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should has_many :medicines }
end