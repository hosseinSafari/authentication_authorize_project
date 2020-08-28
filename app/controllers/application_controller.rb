class ApplicationController < ActionController::API
  before_action :authorize

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      render json: { message: ['Please log in'] }, status: 401
    end
  end
end
