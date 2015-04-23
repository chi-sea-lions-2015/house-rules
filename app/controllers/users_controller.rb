class UsersController < ApplicationController

  def index
    @house = House.find_by(id: params[:id])
    @users = @house.users
  end

  def show
    @user = User.find(params[:id])
  end

  # def index
  # end
  def welcome
  end

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
    if @user = current_user
      @user = User.find(current_user.id)
      @user.update_attributes(user_params)
      @user.save!
      redirect_to user_path(@user)
    else
      redirect_to '/login'
    end
  end

  # def destroy
  # end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :avatar, :password)
    end

end
