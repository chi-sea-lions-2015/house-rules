class HousesController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index]

  # def index
  #   @houses = House.all
  #   render json: @houses, each_serializer: HousesSerializer
  # end

  def show
    @house = House.find(params[:id]).includes(:property_manager)
    render json: @house, serializer: HouseSerializer
  end

  def create
    @user = current_user
    @address = Address.new(address_params)
    if @address.save
      @house = House.new(house_params)
      if @house.save
        @user.housing_assignments.create(user: @user, house: @house)
        render json: @house, serializer: HouseSerializer
      else
        render json: { error: t('house_create_error') }, status: :unprocessable_entity
      end
    else
      render json: { error: t('address_create_error') }, status: :unprocessable_entity
    end
  end

  def update
    @house = House.find(params[:id])
    @house.update_attributes(house_params)
    render :nothing => true, :status => 200
  end

  def destroy
    @house = House.find(params[:id])
    @house.destroy
    render :nothing => true, :status => 200
  end

  # def join
  #   @user = current_user
  #   @house = House.find(params[:id])
  # end

  # def join_update
  #   @house = House.find(params[:id])
  #   @user = current_user
  #   if params[:join][:house_key] == @house.house_key
  #     HousingAssignment.create(user_id: @user.id, house_id: @house.id)
  #     redirect_to house_path(@house)
  #   else
  #     render 'join'
  #   end
  # end

  private

  def house_params
    params.require(:house).permit(:name, :house_key)
  end

  def address_params
    params.require(:house).require(:address).permit(:street, :city, :state, :zip_code)
  end
end
