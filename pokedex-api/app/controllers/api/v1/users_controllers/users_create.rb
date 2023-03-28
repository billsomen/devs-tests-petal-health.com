class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: { error: 'Error Creating user' },
             status: :error
    end
  end
end
