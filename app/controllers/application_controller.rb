class ApplicationController < ActionController::API
  before_action :authorize

  protected

  def authorize
    render json: { message: ['Please log in'] }, status: 401 unless User.find(session[:user_id])
    if decode_token
      user_id = decode_token[0]['user_id']
      render json: { message: ['Please log in'] }, status: 401 unless User.find(user_id)
    else
      render json: { message: ['Please log in'] }, status: 401
    end
  end

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def decode_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT.DecodeError
        nil
      end
    end
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end
end
