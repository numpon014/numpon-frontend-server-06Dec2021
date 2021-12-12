class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:create]

  # GET /users
  def index
    @users = User.all

    render json: @users, :except => [:password_digest, :created_at, :updated_at]
  end

  # GET /users/1
  def show
    render json: @user,
           :include => { :experiences => { :except => [ :created_at, :updated_at ] } },
           :except => [:password_digest, :created_at, :updated_at]
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      payload = { user_id: @user.id }
      token = create_token(payload)
      time = Time.now + 24.hours.to_i
      json_response({
                      id: @user.id,
                      username: @user.username,
                      token: token,
                      exp: time.strftime('%m-%d-%Y %H:%M')
                    })
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:username, :password, :password_confirmation, :name, :avatar, :age)
    end
end
