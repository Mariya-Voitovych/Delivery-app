describe PackagePolicy do
  subject { described_class }

  before :each do
    DeliveryManager.create(email: 'manager@gmail.com', password: 'password', enabled: true)
    Courier.create(name: 'Mary', email: 'mary@gmail.com')
  end

  permissions :create? do
    it 'denies access if user is not delivery manager' do
      expect(subject).not_to permit(User.new(email: 'not_manager@gmail.com', password: '111111'),
                                    Package.new(estimated_delivery_date: '12.3.23'))
    end

    it 'grants access if user is delivery manager' do
      expect(subject).to permit(User.new(email: 'manager@gmail.com', password: '111111', role: 'delivery_manager'),
                                Package.new(estimated_delivery_date: '12.3.23'))
    end
  end

  permissions :show? do
    it 'denies access if user is courier' do
      expect(subject).not_to permit(User.new(email: 'manager@gmail.com', password: '111111'),
                                    Package.new(estimated_delivery_date: '12.3.23'))
    end

    it 'grants access if user is courier' do
      expect(subject).to permit(User.new(email: 'mary@gmail.com', password: '111111'),
                                Package.new(estimated_delivery_date: '12.3.23'))
    end
  end
end
