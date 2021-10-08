# frozen_string_literal: true

class PackageAssignmentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @package_assignment = PackageAssignment.new
  end

  def create
    @package_assignment = PackageAssignment.create(package_assignment_params)
    authorize @package_assignment
    if @package_assignment.save
      PackageAssignment::SetDeliveryStatusAssigned.new(@package_assignment).call
      render status: :created
    else
      render status: :unprocessable_entity, json: @package_assignment.errors.full_messages
    end
  end

  private

  def package_assignment_params
    params.require(:package_assignment).permit(:courier_id, :package_id)
  end 
end
