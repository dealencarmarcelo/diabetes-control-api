require 'rails_helper'
require 'shoulda/matchers'

describe Measurement, type: :model do
    it { should validate_presence_of(:value) }
    
    it { should belong_to(:user) }
end