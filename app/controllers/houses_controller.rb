class HousesController < ApplicationController

  def index
  end

  def show
    @house = House.find(params[:id])
    @assignment = HousingAssignment.where(user: current_user, house: @house.id)
  end

  def new
    @house = House.new
  end

  def create
    @user = current_user
    @address = Address.new(address_params)
    if @address.save
      @house = @user.houses.new(house_params)
      if @house.save
        @user.housing_assignment.create(user: @user, house: @house)
        redirect_to house_path(@house)
      else
        render "new"
      end
    else
      render "new"
    end
  end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

  private

  def house_params
    params.require(:house).permit(:name)
  end

  def address_params
    params.require(:house).require(:address).permit(:street, :city, :state, :zip_code)
  end

end
