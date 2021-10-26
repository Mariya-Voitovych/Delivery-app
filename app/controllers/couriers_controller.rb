# frozen_string_literal: true

class CouriersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_courier, only: %w[show edit update destroy] 

  def index
    @couriers = Courier.all
  end

  def show;  end

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

  def edit;  end

  def update
    authorize @courier
    if @courier.update(courier_params)
      redirect_to courier_path(@courier)
    else
      render status: :unprocessable_entity, json: @courier.errors.full_messages
    end
  end

  def destroy
    authorize Courier
    @courier.destroy

    redirect_to couriers_path
  end

  private

  def courier_params
    params.require(:courier).permit(:name, :email, :password, :password_confirmation)
  end

  def find_courier
    @courier = Courier.find(params[:id])
  end  
end
