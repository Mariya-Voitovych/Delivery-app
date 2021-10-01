describe PackagePolicy do
  subject { described_class }

  permissions :create? do
    it 'denies access if user is not delivery manager' do
      expect(subject).not_to permit(User.new(email: 'user@gmail.com', password: '111111'),
                                    Package.new(estimated_delivery_date: '12.3.23'))
    end

    it 'grants access if user is delivery manager' do
      expect(subject).to permit(User.new(email: 'user@gmail.com', password: '111111', role: 'delivery_manager'),
                                Package.new(estimated_delivery_date: '12.3.23'))
    end
  end
end
