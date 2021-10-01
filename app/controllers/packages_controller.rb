# frozen_string_literal: true

class PackagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @packages = Package.all
  end

  def new
    @package = Package.new
  end

  def create
    authorize Package
    @package = Package::Create.call(package_params)

    if @package.persisted?
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
    params.require(:package).permit(:estimated_delivery_date, :delivery_status, :courier_id)
  end
end
