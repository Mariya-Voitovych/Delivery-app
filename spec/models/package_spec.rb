require 'rails_helper'

RSpec.describe Package, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:tracking_number) }
  end
end
