class AuthenticationController < ApplicationController
  skip_before_action :authenticate, only: [:login]

  def login
    @user = User.find_by(username: params[:username])
    if @user
      if @user.authenticate(params[:password])
        payload = { user_id: @user.id}
        token = create_token(payload)
        time = Time.now + 24.hours.to_i
        render json: {
          username: @user.username,
          token: token,
          exp: time.strftime("%m-%d-%Y %H:%M"),
        }
      else
        render json: { message: "Authentication Failed" }
      end
    else
      render json: { message: "Authentication Failed" }
    end
  end

  def login_params
    params.permit(:username, :password)
  end
end
