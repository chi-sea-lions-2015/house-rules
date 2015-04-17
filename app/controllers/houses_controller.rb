class HousesController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:user_id])
    @house = House.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @house = House.new
  end

  def create
    @user = User.find(params[:user_id])
    @address = Address.new(address_params)
    if @address.save
      @house = @user.houses.new(house_params)
      if @house.save
        redirect_to user_house_path(@user, @house)
      else
        render "new"
      end
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def house_params
    params.require(:house).permit(:name)
  end

  def address_params
    params.require(:house).require(:address).permit(:street, :city, :state, :zip_code)
  end

end
