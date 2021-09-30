# frozen_string_literal: true

class PackagesController < ApplicationController
  before_action :authenticate_delivery_manager!

  def index
    @packages = Package.all
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.create(package_params)
    authorize Package
    if @package.save
      render status: :created
    else
      render status: :unprocessable_entity, json: @package.errors.full_messages
    end
  end

  def show
    @package = Package.find(params[:id])
  end

  private

  def package_params
    params.require(:package).permit(:estimated_delivery_date, :tracking_number, :delivery_status, :courier_id)
  end
end