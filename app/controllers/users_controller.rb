class UsersController < ApplicationController

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
    if @user.save
      log_in @user
      flash[:success] = "Welcome!"
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def update
    @user = User.find_by(id: session[:user_id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  # def destroy
  # end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :avatar, :password, :password_confirmation)
    end

end
