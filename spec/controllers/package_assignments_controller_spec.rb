require 'rails_helper'

RSpec.describe(PackageAssignmentsController, type: :controller) do

  let!(:courier) { create(:courier) }
  let!(:package) { create(:package) }
  let(:package_assignment) { create(:package_assignment) }
  let(:user) { create(:user, email: 'manager@gmail.com') }

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

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to(eq(200))
    end
  end
end
