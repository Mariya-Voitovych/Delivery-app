require 'rails_helper'

RSpec.describe(PackageAssignmentsController, type: :controller) do
  let!(:courier) { Courier.create(name: 'Petro', email: 'petro@gmail.com', password_digest: '111111') }
  let!(:package) { Package.create(estimated_delivery_date: '12.09.21', delivery_status: 'processing') }
  let(:package_assignment) { PackageAssignment.create(courier_id: courier.id, package_id: package.id) }
  let!(:delivery_manager) { DeliveryManager.create(email: 'manager@gmail.com', password: 'password', enabled: true) }
  let(:user) { User.create(email: 'manager@gmail.com', password: '111111', role: 'delivery_manager') }

  before do
    sign_in user
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to(eq(200))
    end
  end

  describe 'POST create' do
    it 'successfully creates a new package assignment' do
      expect do
        post(:create, params: { package_assignment: { courier_id: courier.id, package_id: package.id } })
      end.to(change(PackageAssignment, :count).by(1))
    end
  end
end
