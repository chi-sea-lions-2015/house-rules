class HousesController < ApplicationController

  def index
    @houses = House.all
  end

  def show
    @user = current_user
    @house = @user.houses.first
    @houses = House.where(id: params[:id])
    if HousingAssignment.find_by(user_id: @user.id, house_id: @house.id)
      @property_manager = @house.property_manager
      @assignment = HousingAssignment.where(user: current_user, house: @house.id)
    else
      redirect_to "/houses/#{@house.id}/join"
    end
  end

  def roommates
    @user = current_user
    @house = House.find(params[:id])
    @roommates = @house.users
  end

  def new
    @house = House.new
    @address = Address.new
  end

  def create
    @user = current_user
    if @user.houses != nil
    @house = House.new(house_params)
    if @house.save
      @address = @house.address=Address.new(address_params)
      if @address.save
        @user.housing_assignments.create(user: @user, house: @house)
        redirect_to house_path(@house)
      else
        render "new"
      end
    else
      render "new"
    end
    end
  end

  def edit
    @house = House.find(params[:id])
    @address = @house.address
  end

  def update
    @house = House.find(params[:id])
    @house.update_attributes(house_params)
    redirect_to house_path(@house)
  end

  def destroy
    @user = current_user
    @house = House.find(params[:id])
    redirect_to user_path(@user)
  end

  def join
    @user = current_user
    @house = House.find(params[:id])
  end

  def join_update
    @house = House.find(params[:id])
    @user = current_user
    if params[:join][:house_key] == @house.house_key
      HousingAssignment.create(user_id: @user.id, house_id: @house.id)
      redirect_to house_path(@house)
    else
      render 'join'
    end
  end

  private

  def house_params
    params.require(:house).permit(:name, :house_key)
  end

  def address_params
    params.require(:house).require(:address).permit(:street, :city, :state, :zip_code)
  end

end
