class Api::V1::UsersController < ApplicationController
  before_action :find_user, except: %i[create, index]

  require_relative './users_controllers/users_index'
  require_relative './users_controllers/users_show'
  require_relative './users_controllers/users_create'

  def find_user
    @user = User.find_by(id: params[:id])

  rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :not_found
  end
  
  def user_params
    params.permit(
      :name, :user_role, :role_id, :password_digest
    )
  end
end
