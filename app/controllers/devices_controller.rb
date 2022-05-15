class DevicesController < ApplicationController
  # PUT devices/:id
  def update
    device = Device.find_by(id: params[:id])
    unless device
      render json: { success: false, errors: ['device not found'] }, status: :unprocessable_entity
      return
    end

    device.update(update_params)
    if device.errors.blank?
      render json: { success: true, data: device }, status: :ok
    else
      render json: { success: false, errors: device.errors }, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.permit(:offset)
  end
end
