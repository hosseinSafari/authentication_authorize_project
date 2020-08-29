class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    @user = User.find_by( email: params[:email] )
    if @user.try(:authenticate, params[:password])
      session[:user_id] = @user.id
      token = encode_token({ user_id: @user.id })
      render json: {user: @user, token: token}, status: 200
    else
      render json: { message: ['Invalid user/password combination'] }, status: 400
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: ['Logged out'] }, status: 200
  end
end
