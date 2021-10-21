describe CourierPolicy do
  subject { described_class }

  let(:delivery_manager) { create(:delivery_manager, enabled: true) }

  permissions :create?, :update?, :destroy? do
    it 'denies access if user is not delivery manager' do
      expect(subject).not_to permit(User.new(email: 'not_manager@gmail.com', password: '111111'),
                                    Courier.new(name: 'Pedro'))
    end

    it 'grants access if user is delivery manager' do
      expect(subject).to permit(User.new(email: delivery_manager.email, password: '111111', role: 'delivery_manager'),
                                Courier.new(name: 'Pedro'))
    end
  end
end
