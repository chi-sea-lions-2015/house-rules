class UsersController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:create]
  def show
    @user = User.find(params[:id])
  end

  # def index
  # end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    p @user
    if @user.save
      render json: @user, serializer: SessionSerializer, root: nil
    else
      render json: { error: t('user_create_error') }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find_by(id: session[:user_id])
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
  end

  # def destroy
  # end

  private

    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :email, :phone, :avatar, :password, :password_confirmation)
    end

end
