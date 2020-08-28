class UsersController < ApplicationController
  skip_before_action :authorize
  before_action :user_params

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: ['Saved'] }, status: 200
    else
      render json: { message: ['Not Saved'] }, status: 400
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
