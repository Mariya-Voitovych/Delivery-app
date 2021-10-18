require 'rails_helper'

RSpec.describe 'TokenApi', type: :request do
  def json
    JSON.parse(response.body)
  end

  def auth_header
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    { 'Authorization': "Bearer #{token}" }
  end

  let(:courier) { Courier.create(name: 'Mary', email: 'mary@gmail.com', password: '111111') }

  let!(:wrong_mail) { 'Faker::Internet.email' }
  let!(:wrong_password) { 'Faker::Internet.password' }

  context 'valid credentials' do
    let(:created) { 201 }

    before do
      login_params = {
        auth: {
          email: courier.email,
          password: courier.password
        }
      }
      post '/courier_token', params: login_params
    end

    it 'returns "created" status code' do
      expect(response).to have_http_status(created)
    end

    it 'has empty response body' do
      expect(json['jwt']).not_to be_nil
    end
  end

  context 'invalid credentials' do
    let(:not_found) { 404 }

    context 'invalid email' do
      before do
        login_params = {
          auth: {
            email: wrong_mail,
            password: courier.password
          }
        }
        post '/courier_token', params: login_params
      end

      it 'returns "not found" status code' do
        expect(response).to have_http_status(not_found)
      end

      it 'returns nothing' do
        expect(response.body).to be_empty
      end
    end

    context 'invalid password' do
      before do
        login_params = {
          auth: {
            email: courier.email,
            password: wrong_password
          }
        }
        post '/courier_token', params: login_params
      end

      it 'returns "not found" status code' do
        expect(response).to have_http_status(not_found)
      end

      it 'has empty response body' do
        expect(response.body).to be_empty
      end
    end
  end
end

