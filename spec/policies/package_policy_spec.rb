describe PackagePolicy do
  subject { described_class }

  let(:delivery_manager) { create(:delivery_manager, enabled: true) }
  let(:courier) { create(:courier) }

  permissions :create? do
    it 'denies access if user is not delivery manager' do
      expect(subject).not_to permit(User.new(email: 'not_manager@gmail.com', password: '111111'),
                                    Package.new(estimated_delivery_date: '12.3.23'))
    end

    it 'grants access if user is delivery manager' do
      expect(subject).to permit(User.new(email: delivery_manager.email, password: '111111', role: 'delivery_manager'),
                                Package.new(estimated_delivery_date: '12.3.23'))
    end
  end

  permissions :show? do
    it 'denies access if user is courier' do
      expect(subject).not_to permit(User.new(email: 'wrong@gmail.com', password: '111111'),
                                    Package.new(estimated_delivery_date: '12.3.23'))
    end

    it 'grants access if user is courier' do
      expect(subject).to permit(User.new(email: courier.email, password: '111111'),
                                Package.new(estimated_delivery_date: '12.3.23'))
    end
  end
end
