# frozen_string_literal: true

class CouriersController < ApplicationController
  before_action :authenticate_user!

  def index
    @couriers = Courier.all
  end

  def show
    @courier = Courier.find(params[:id])
  end

  def new
    @courier = Courier.new
  end

  def create
    authorize Courier
    @courier = Courier.create(courier_params)
    if @courier.save
      render status: :created
    else
      render status: :unprocessable_entity, json: @courier.errors.full_messages
    end
  end

  def edit
    @courier = Courier.find(params[:id])
  end

  def update
    authorize Courier
    @courier = Courier.find(params[:id])
    if @courier.update(courier_params)
      redirect_to courier_path(@courier)
    else
      render status: :unprocessable_entity, json: @courier.errors.full_messages
    end
  end

  def destroy
    authorize Courier
    @courier = Courier.find(params[:id])
    @courier.destroy

    redirect_to couriers_path
  end

  private

  def courier_params
    params.require(:courier).permit(:name, :email, :password, :password_confirmation)
  end
end
