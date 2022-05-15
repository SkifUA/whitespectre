class UsersController < ApplicationController
  # GET /users/:id
  def show
    user = User.includes(:temperatures).find_by(id: params[:id])

    if user
        # TODO use Serializer, pagination for temperatures
        user_data = user.as_json.merge(temperatures: user.temperatures)
        render json: { success: true, data: user_data }, status: :ok
      else
        render json: { success: false, errors: ['user not found'] }, status: :unprocessable_entity
    end
  end
end
