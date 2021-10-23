require 'swagger_helper'

RSpec.describe 'api', type: :request do
  let!(:delivery_manager) { create(:delivery_manager) }
  let!(:user) { create(:user, email: delivery_manager.email) }
  def login(user)
    post user_session_path, :email => user.email, :password => 'password'
  end
  

  path '/package_assignments' do
    post 'package_assignments/' do
      tags 'PackageAssignments'
      description 'Endpoint for creating package assignment'
      consumes 'application/json'
      parameter name: :package_assignment, in: :body, schema: {
        type: :object,
        properties: {
          package_id: { type: :string },
          courier_id: { type: :string }
        },
        required: %w[package_id courier_id]
      }

      response '201', 'package assignment created' do
        let(:package_assignment) { { package_id: package.id, courier_id: courier.id } }
        run_test!
      end
    end
  

    get 'package_assignments/' do
      tags 'PackageAssignments'
      security [ basic_auth: [] ]
      description 'Endpoint for showing all package_assignments data'
      consumes 'application/json'

      response '200', 'package_assignments' do
        run_test!
      end

      response '401', 'authentication failed' do
        run_test!
      end
    end
  end

  path '/package_assignments/new' do
    get 'package_assignments/new/' do
      tags 'PackageAssignments'
      description 'Endpoint for creating new package_assignment'
      consumes 'application/json'

      response '200', 'new package_assignments' do
        run_test!
      end
    end
  end
end
