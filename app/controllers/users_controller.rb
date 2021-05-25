class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :set_user, only: [:show, :update, :destroy]

  # # GET /users
  # def index
  #   @users = User.all
  #
  #   render json: @users
  # end
  #
  # # GET /users/1
  # def show
  #   render json: @user
  # end
  #
  # # POST /users
  # def create
  #   @user = User.new(user_params)
  #
  #   if @user.save
  #     render json: @user, status: :created, location: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # PATCH/PUT /users/1
  # def update
  #   if @user.update(user_params)
  #     render json: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # DELETE /users/1
  # def destroy
  #   @user.destroy
  # end

  def user_one
    user = User.find(params[:user_id])
    render json: user
  end
  def user_all
    users = User.all
    render json: users
  end

  def user_login
    user = User.find_by(email: params[:email])
    render json: user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :department, :password_digest, :image_url, :name)
    end
end
