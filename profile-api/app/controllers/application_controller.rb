class ApplicationController < ActionController::API
  before_action :authenticate

  def authenticate
    if request.headers["Authorization"]
      begin
        auth_header = request.headers['Authorization']
        token = auth_header.split(' ').last if auth_header
        decode_token = JWT.decode(token, secret)
        user_id = decode_token.first["user_id"]
        @user = User.find(user_id)
      rescue => exception
        render json: { message: "Error #{exception}" }, status: :unauthorized
      end
    else
      render json: { message: "No Authorization header sent"  }, status: :unauthorized
    end
  end

  def secret
    ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
  end

  def create_token(payload)
    JWT.encode(payload, secret)
  end
end
