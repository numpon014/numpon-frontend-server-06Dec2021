class ApplicationController < ActionController::API
  include Response
  before_action :authenticate
  skip_before_action :authenticate, only: [:show_version]

  def authenticate
    if request.headers["Authorization"]
      begin
        auth_header = request.headers['Authorization']
        token = auth_header.split(' ').last if auth_header
        decode_token = JWT.decode(token, secret)
        user_id = decode_token.first["user_id"]
        @user = User.find(user_id)
      rescue StandardError => exception
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

  # GET /show_version/
  def show_version
    version_file = "app/assets/version.json"
    unless File.exist?('app/assets/version.json')
      version_file = "app/assets/version.template.json"
    end

    render json: JSON.pretty_generate(JSON.parse(File.read(version_file)))
  end
end
