require 'swagger_helper'

RSpec.describe 'api', type: :request do

  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: courier.id }).token
    { 'Authorization': "Bearer #{token}" }
  end

  let(:courier) { create(:courier) }
  let!(:delivery_manager) { create(:delivery_manager, email: courier.email) }
  let(:user) { create(:user, email: courier.email) }
  let(:Authorization) { "Basic #{::Base64.strict_encode64('jsmith:jspass')}" }
  let(:api_key) { 'foobar' }

  let(:'access-token') { authenticated_header(courier)['access-token'] }
  let(:'token-type') { authenticated_header(courier)['token-type'] }
  let(:client) { authenticated_header(courier)['client'] }
  let(:expiry) { authenticated_header(courier)['expiry'] }
  let(:uid) { authenticated_header(courier)['uid'] }

  path '/auth/signin/' do
    post 'courier sign_in' do
      tags 'couriers'
      consumes 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      produces 'application/json'

      response '200', 'courier logged in' do
        let(:params) { { email: courier.email, password: courier.password } }
        header 'access-token', type: :string, description: 'Access token'
        header 'client', type: :string, description: 'Client id'
        header 'expiry', type: :string, description: 'Token expiry date'
        header 'uid', type: :string, description: 'User email'
        run_test!
      end
    end
  end    

  path '/couriers' do
    post 'couriers/' do
      tags 'Couriers'
      security [{ basic_auth: [], api_key: [] }]
      description 'Endpoint for creating couriers data'
      consumes 'application/json'
      parameter name: :courier, in: :body
      response '201', 'courier created' do schema type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]

        parameter name: 'access-token', in: :header, type: :string
        parameter name: 'token-type', in: :header, type: :string
        parameter name: 'client', in: :header, type: :string
        parameter name: 'expiry', in: :header, type: :string
        parameter name: 'uid', in: :header, type: :string
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
