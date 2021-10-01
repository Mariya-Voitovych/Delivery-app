require 'rails_helper'

RSpec.describe(PackagesController, type: :controller) do
  let(:courier) { Courier.create(name: 'Mary', email: 'mary@gmail.com') }
  let!(:package) { Package.create(estimated_delivery_date: '12.09.21', courier_id: courier.id) }
  let!(:delivery_manager) { DeliveryManager.create(email: 'manager@gmail.com', password: 'password', enabled: true) }
  let(:user) { User.create(email: 'manager@gmail.com', password: '111111', role: 'delivery_manager') }

  before do
    sign_in user
  end

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to(eq(200))
    end
  end

  describe 'GET show' do
    it 'has a 200 status code' do
      get :show, params: { id: package.id }
      expect(response.status).to(eq(200))
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to(eq(200))
    end
  end

  describe 'POST create' do
    it 'successfully creates a new package' do
      expect do
        post(:create, params: { package: { estimated_delivery_date: '12.09.21', courier_id: courier.id } })
      end.to(change(Package, :count).by(1))
    end
  end
end
