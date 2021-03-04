require 'rails_helper'
require 'shoulda/matchers'

describe Consumption, type: :model do
    it { should validate_presence_of(:quantity) }
    it { should belongs_to :stock }
end