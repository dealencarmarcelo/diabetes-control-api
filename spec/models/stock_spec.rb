require 'rails_helper'
require 'shoulda/matchers'

describe Stock, type: :model do
    it { should validate_presence_of(:quantity) }
    
    it { should belong_to(:stockable) }
    it { should belong_to(:user) }
end