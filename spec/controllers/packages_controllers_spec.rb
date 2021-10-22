require 'rails_helper'

RSpec.describe(PackagesController, type: :controller) do

  let(:courier) { create(:courier) }
  let!(:package) { create(:package, courier_id: courier.id) }
  let!(:delivery_manager) { create(:delivery_manager, email: courier.email) }
  let!(:user) { create(:user, email: courier.email) }

  before do
    sign_in user
  end

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index, params: { courier_id: courier.id }
      expect(response.status).to(eq(200))
    end
  end

  describe 'GET show' do
    it 'has a 200 status code' do
      get :show, params: { courier_id: courier.id, id: package.id }
      expect(response.status).to(eq(200))
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new, params: { courier_id: courier.id }
      expect(response.status).to(eq(200))
    end
  end

  describe 'POST create' do
    it 'successfully creates a new package' do
      expect do
        post(:create,
             params: { courier_id: courier.id,
                       package: { estimated_delivery_date: '12.09.21', courier_id: courier.id } })
      end.to(change(Package, :count).by(1))
    end
  end

  describe 'GET edit' do
    it 'has a 200 status code' do
      get :edit, params: { courier_id: courier.id, id: package.id  }
      expect(response.status).to(eq(200))
    end
  end

  describe 'PUT update' do
    let(:package_params) { { estimated_delivery_date: '09.03.2022' } }

    it 'successfully updated' do
      put :update, params: { courier_id: courier.id, id: package.id, package: package_params }
      package.reload

      expect(package.estimated_delivery_date).to(eql(package_params[:estimated_delivery_date].to_date))
    end
  end
end
