require 'swagger_helper'

RSpec.describe 'api/my', type: :request do
    path '/couriers' do
  
      post 'Creates a courier' do
        tags 'Couriers'
        consumes 'application/json'
        parameter name: :courier, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string }
          },
          required: [ 'name', 'email' ]
        }
  
        response '201', 'courier created' do
          let(:courier) { { name: 'Pavlo', email: 'pavlo@gmail.com' } }
          run_test!
        end
      end

      get 'Show all couriers' do
        tags 'Couriers'
        consumes 'application/json'
        parameter name: :courier, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string }
          },
          required: [ 'name', 'email' ]
        }
  
        response '201', 'index couriers' do
          run_test!
        end
      end
    end

    path '/couriers/new' do
  
      get 'new courier' do
        tags 'Couriers'
        consumes 'application/json'
        parameter name: :courier, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string }
          },
          required: [ 'name', 'email' ]
        }
  
        response '201', 'new couriers' do
          run_test!
        end
      end
    end

    path '/couriers/{id}' do

      get 'Show a courier' do
        tags 'Couriers'
        produces 'application/json', 'application/xml'
        parameter name: :id, in: :path, type: :string
  
        response '200', 'courier found' do
          schema type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              email: { type: :string }
            },
            required: [ 'id', 'name', 'email' ]
  
          let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com').id }
          run_test!
        end
  
        response '404', 'courier not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end

      put 'Update courier' do
        tags 'Couriers'
        produces 'application/json', 'application/xml'
        parameter name: :id, in: :path, type: :string
  
        response '200', 'courier found' do
          schema type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              email: { type: :string }
            },
            required: [ 'id', 'name', 'email' ]
  
          let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com').id }
          run_test!
        end
  
        response '404', 'courier not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end

      delete 'Delete a courier' do
        tags 'Couriers'
        produces 'application/json', 'application/xml'
        parameter name: :id, in: :path, type: :string
  
        response '200', 'courier found' do
          schema type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              email: { type: :string }
            },
            required: [ 'id', 'name', 'email' ]
  
          let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com').id }
          run_test!
        end
  
        response '404', 'courier not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end

    path '/couriers/{id}/packages' do
  
      post 'Creates a package' do
        tags 'Packages'
        consumes 'application/json'
        parameter name: :package, in: :body, schema: {
          type: :object,
          properties: {
            delivery_status: { type: :string },
            estimated_delivery_date: { type: :date },
            tracking_number:  { type: :string },
            courier_id: {type: :string}
          },
          required: [ 'delivery status', 'estimated delivery_date', 'tracking number' ]
        }
  
        response '201', 'package created' do
          let(:id) { Courier.create(name: 'Mary', email: 'mary@gmail.com').id }
          let(:package) { { estimated_delivery_date: '12.09.21', courier_id: id } }
          run_test!
        end

        response "422", "invalid request" do
          let(:package) { { estimated_delivery_date: '12.09.21' } }
          run_test!
        end
      end
    end
     
end
