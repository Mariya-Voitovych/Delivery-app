# frozen_string_literal: true

class CouriersController < ApplicationController
  before_action :authenticate_delivery_manager!
  
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
    @courier = Courier.create(courier_params)
    authorize Courier
    if @courier.save
      render status: :created
    else
      render status: :unprocessable_entity, json: word.errors.full_messages
    end
  end

  def edit
    @courier = Courier.find(params[:id])
  end

  def update
    @courier = Courier.find(params[:id])
    authorize Courier
    if @courier.update(courier_params)
      redirect_to courier_path(@courier)
    else
      render status: :unprocessable_entity, json: @courier.errors.full_messages
    end
  end

  def destroy
    @courier = Courier.find(params[:id])
    authorize Courier
    @courier.destroy

    redirect_to couriers_path
  end

  private

  def courier_params
    params.require(:courier).permit(:name, :email)
  end
end