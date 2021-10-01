require 'rails_helper'

RSpec.describe Courier, type: :model do
  context 'when courier has relations' do
    subject(:courier) { described_class.new }

    it { expect(courier).to(have_many(:packages)) }
  end
end
