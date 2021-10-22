require 'swagger_helper'

RSpec.describe 'api/', type: :request do
  path '/couriers' do
    post 'couriers/' do
      tags 'Couriers'
      description 'Endpoint for creating couriers data'
      consumes 'application/json'
      parameter name: :courier, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string }
        },
        required: %w[name email]
      }

      response '201', 'courier created' do
        let(:courier) { { name: 'Pavlo', email: 'pavlo@gmail.com' } }
        run_test!
      end
    end

    get 'couriers/' do
      tags 'Couriers'
      description 'Endpoint for showing all couriers data'
      consumes 'application/json'
      response '201', 'index couriers' do
        run_test!
      end
    end
  end

  path '/couriers/new' do
    get 'couriers/new' do
      tags 'Couriers'
      description 'Endpoint for creating courier'
      consumes 'application/json'
      response '201', 'new couriers' do
        run_test!
      end
    end
  end

  path '/couriers/{id}' do
    get 'couriers/:courier_id' do
      tags 'Couriers'
      description 'Endpoint for showing couriers data'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'courier found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string }
               },
               required: %w[id name email]

        let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com').id }
        run_test!
      end

      response '404', 'courier not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'couriers/:courier_id' do
      tags 'Couriers'
      description 'Endpoint for updating couriers data'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'courier found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string }
               },
               required: %w[id name email]

        let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com').id }
        run_test!
      end

      response '404', 'courier not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'couriers/:courier_id' do
      tags 'Couriers'
      description 'Endpoint for delete courier'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'courier found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string }
               },
               required: %w[id name email]

        let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com').id }
        run_test!
      end

      response '404', 'courier not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
