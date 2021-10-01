require 'rails_helper'

RSpec.describe Package::Create do
  let!(:courier) { Courier.create(email: 'test@test.com', name: 'Petro') }
  let!(:params) { { courier_id: courier.id } }

  it 'create package' do
    package = described_class.call(params)

    expect(Package.find(package.id)).to be_an_instance_of(Package)
    expect(package).to be_persisted
  end
end
