class UsersController < ApplicationController
  skip_before_action :authorize
  before_action :user_params

  def create
    @user = User.new(user_params)
    if @user.save
      token = encode_token({ user_id: @user.id })
      render json: {user: @user, token: token}, status: 200
    else
      render json: { message: ['Not Saved'] }, status: 400
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
