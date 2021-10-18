describe PackageAssignmentPolicy do
  subject { described_class }

  let!(:courier) { Courier.create(email: 'test@test.com', name: 'Petro') }
  let!(:package) do
    Package.create(estimated_delivery_date: '12.09.21', delivery_status: 'processing', courier_id: courier.id)
  end
  let!(:package_new) do
    Package.create(estimated_delivery_date: '12.09.21', tracking_number: 'YA11111111AA', courier_id: courier.id)
  end

  before :each do
    DeliveryManager.create(email: 'manager@gmail.com', password: 'password', enabled: true)
  end

  permissions :create? do
    it 'denies access if user is not delivery manager' do
      expect(subject).not_to permit(User.new(email: 'not_manager@gmail.com', password: '111111'),
                                    PackageAssignment.new(courier_id: courier.id, package_id: package.id))
    end

    it 'denies access if delivery status is not processing' do
      expect(subject).not_to permit(User.new(email: 'manager@gmail.com', password: '111111'),
                                    PackageAssignment.new(courier_id: courier.id, package_id: package_new.id))
    end

    it 'grants access if user is delivery manager and delivery status is not processing' do
      expect(subject).to permit(User.new(email: 'manager@gmail.com', password: '111111', role: 'delivery_manager'),
                                PackageAssignment.new(courier_id: courier.id, package_id: package.id))
    end
  end
end
