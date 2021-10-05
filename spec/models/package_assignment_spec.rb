require 'rails_helper'

RSpec.describe PackageAssignment, type: :model do
  describe 'associations' do
    it { is_expected.to(belong_to(:courier)) }
    it { is_expected.to(belong_to(:package)) }
  end
end
