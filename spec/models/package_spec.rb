require 'rails_helper'

RSpec.describe Package, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:tracking_number) }
  end

  describe 'associations' do
    it { is_expected.to(have_many(:package_assignments)) }
    it { is_expected.to(have_many(:couriers)) }
  end
end
