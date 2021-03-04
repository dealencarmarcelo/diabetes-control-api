require 'rails_helper'
require 'shoulda/matchers'

describe Measurement, type: :model do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:status) }
    it { should belongs_to :user }
end