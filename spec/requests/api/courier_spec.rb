require 'swagger_helper'

RSpec.describe 'api', type: :request do

  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    { 'Authorization': "Bearer #{token}" }
  end

  let!(:delivery_manager) { create(:delivery_manager) }
  let(:user) { create(:user, email: delivery_manager.email) }
  let(:Authorization) { "Basic #{::Base64.strict_encode64('jsmith:jspass')}" }
  let(:api_key) { 'foobar' }

  before do
    authenticate(user)
  end

  path '/couriers' do
    post 'couriers/' do
      tags 'Couriers'
      security [{ basic_auth: [], api_key: [] }]
      description 'Endpoint for creating couriers data'
      consumes 'application/json'
      parameter name: :courier, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response '201', 'courier created' do
        let(:courier) { { name: 'Pavlo', email: 'pavlo@gmail.com', password: 'password' } }
        run_test!
      end
    end

    get 'couriers/' do
      tags 'Couriers'
      security [{ basic_auth: [], api_key: [] }]
      description 'Endpoint for showing all couriers data'
      consumes 'application/json'
      response '200', 'index couriers' do
        run_test!
      end
    end
  end

  path '/couriers/new' do
    get 'couriers/new' do
      tags 'Couriers'
      security [{ basic_auth: [], api_key: [] }]
      description 'Endpoint for creating courier'
      consumes 'application/json'
      response '200', 'new couriers' do
        run_test!
      end
    end
  end  

    path '/couriers/{id}' do
      put 'couriers/:courier_id' do
        tags 'Couriers'
        security [{ basic_auth: [], api_key: [] }]
        description 'Endpoint for updating couriers data'
        produces 'application/json', 'application/xml'
        parameter name: :id, in: :path, type: :string
  
        response '200', 'courier found' do
          schema type: :object,
                 properties: {
                   id: { type: :string },
                   name: { type: :string },
                   email: { type: :string },
                   password: { type: :string }
                 },
                 required: %w[id]
  
          let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com', password: 'password').id }
          run_test!
        end
      end

      get 'couriers/:courier_id' do
        tags 'Couriers'
        security [{ basic_auth: [], api_key: [] }]
        description 'Endpoint for showing couriers data'
        produces 'application/json', 'application/xml'
        parameter name: :id, in: :path, type: :string
  
        response '200', 'courier found' do
          schema type: :object,
                 properties: {
                   id: { type: :string }
                 },
                 required: %w[id]
  
          let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com', password: 'password').id }
          run_test!
        end
      end

      delete 'couriers/:courier_id' do
        tags 'Couriers'
        security [{ basic_auth: [], api_key: [] }]
        description 'Endpoint for delete courier'
        produces 'application/json', 'application/xml'
        parameter name: :id, in: :path, type: :string

        response '200', 'courier found' do
          schema type: :object,
                 properties: {
                   id: { type: :string }
                 },
                 required: %w[id]

          let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com', password: 'password').id }
          run_test!
        end
      end
    end
end
