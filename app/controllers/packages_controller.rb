# frozen_string_literal: true

class PackagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_valid_courier
  before_action :auth_package, only: %w[create show]
  before_action :find_package, only: %w[show update edit]


  def index
    @courier  = Courier.find(params[:courier_id])
    @packages = @courier.packages.all
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package::Create.new(package_params).call
    if @package.persisted?
      render status: :created
    else
      render status: :unprocessable_entity, json: @package.errors.full_messages
    end
  end

  def show; end

  def edit; end

  def update
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

  def auth_package
    authorize Package
  end

  def find_package
    @package = Package.find(params[:id])
  end  
end
