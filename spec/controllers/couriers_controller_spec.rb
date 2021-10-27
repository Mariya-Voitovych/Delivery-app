require 'rails_helper'

RSpec.describe(CouriersController, type: :controller) do
  let(:courier) { create(:courier) }
  let!(:delivery_manager) { create(:delivery_manager) }
  let(:user) { create(:user, email: delivery_manager.email) }

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
      get :show, params: { id: courier.id }
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
    it 'successfully creates a new courier' do
      expect do
        post(:create,
             params: { courier: { name: 'Ivan', email: 'ivan@gmail.com', password: '111111',
                                  password_confirmation: '111111' } })
      end.to(change(Courier, :count).by(1))
    end
  end

  describe 'GET edit' do
    it 'has a 200 status code' do
      get :edit, params: { id: courier.id }
      expect(response.status).to(eq(200))
    end
  end

  describe 'PUT update' do
    let(:courier_params) { { name: 'Olya', email: 'olya@gmail.com' } }

    it 'successfully updated' do
      put :update, params: { id: courier.id, courier: courier_params }
      courier.reload

      expect(courier.name).to(eql(courier_params[:name]))
      expect(courier.email).to(eql(courier_params[:email]))
    end
  end

  describe 'DELETE destroy' do
    it 'destroy courier' do
      courier.save
      expect do
        delete(:destroy, params: { id: courier.id })
      end.to(change(Courier, :count).by(-1))
    end
  end
end
