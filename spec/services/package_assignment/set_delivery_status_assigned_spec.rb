require 'rails_helper'

RSpec.describe PackageAssignment::SetDeliveryStatusAssigned do
  let!(:courier) { Courier.create(email: 'test@test.com', name: 'Petro') }
  let!(:package) { Package.create(estimated_delivery_date: '12.09.21', delivery_status: 'processing', courier_id: courier.id) }
  let!(:package_assignment) { PackageAssignment.create(courier_id: courier.id, package_id: package.id) }

  it 'change delivery status to assigned' do
    described_class.new(package_assignment).call
    expect(package_assignment.package.delivery_status).to eq('assigned')
  end
end
