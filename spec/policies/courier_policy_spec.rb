describe CourierPolicy do
  subject { described_class }

  permissions :create?, :update?, :destroy? do
    it 'denies access if user is not delivery manager' do
      expect(subject).not_to permit(User.new(email: 'user@gmail.com', password: '111111'), Courier.new(name: 'Pedro'))
    end

    it 'grants access if user is delivery manager' do
      expect(subject).to permit(User.new(email: 'user@gmail.com', password: '111111', role: 'delivery_manager'),
                                Courier.new(name: 'Pedro'))
    end
  end
end
