class Api::V1::UsersController < ApplicationController
  def show
    if @user
      render json: @user, status: :ok
    else
      render json: { error: 'User Not Found' }, status: :not_found
    end
  end
end
