class TemperaturesController < ApplicationController
  # POST /devices/:device_id/temperatures
  def create
    result = TemperatureCreator.call(create_params.to_h)
    if result.success?
      render json: { success: true, data: result.temperature }, status: :ok
    else
      render json: { success: false, errors: result.errors }, status: :unprocessable_entity
    end
  end

  # GET /devices/:device_id/temperatures
  def index
    # TODO add pagination
    @temperatures = Temperature.where(device_id: params[:device_id])
    render json: { data: @temperatures, success: true}, status: :ok
  end

  private

  def create_params
    params.permit(:magnitude, :device_id)
  end
end