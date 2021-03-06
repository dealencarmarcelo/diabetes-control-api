require 'rails_helper'
require 'shoulda/matchers'

describe MedicineType, type: :model do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:kind) }
    
    it { should have_many(:medicines) }
    it { should belong_to(:brand) }
end