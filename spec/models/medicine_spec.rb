require 'rails_helper'
require 'shoulda/matchers'

describe Medicine, type: :model do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:content) }
    it { should belongs_to :medicine_type }
    it { should belongs_to :brand }
end