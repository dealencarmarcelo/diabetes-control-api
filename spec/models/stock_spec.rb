require 'rails_helper'
require 'shoulda/matchers'

describe Stock, type: :model do
    it { should validate_presence_of(:quantity) }
    it { should belongs_to :user }
end