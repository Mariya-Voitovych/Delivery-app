# frozen_string_literal: true

class PackagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courier  = Courier.find(params[:courier_id])
    @packages = @courier.packages.all
  end

  def new
    @package = Package.new
  end

  def create
    authorize Package
    @package = Package::Create.new(package_params).call
    if @package.persisted?
      render status: :created
    else
      render status: :unprocessable_entity, json: @package.errors.full_messages
    end
  end

  def show
    @package = Package.find(params[:id])
  end

  def edit
    @package = Package.find(params[:id])
  end

  def update
    @package = Package.find(params[:id])
    if @package.update(package_params)
      redirect_to courier_package_path(@package)
    else
      render status: :unprocessable_entity, json: @package.errors.full_messages
    end
  end

  private

  def package_params
    params.require(:package).permit(:estimated_delivery_date, :tracking_number, :delivery_status, :courier_id)
  end
end
