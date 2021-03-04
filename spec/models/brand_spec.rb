require 'rails_helper'
require 'shoulda/matchers'

describe Brand, type: :model do
    it { should validate_presence_of(:name) }
end