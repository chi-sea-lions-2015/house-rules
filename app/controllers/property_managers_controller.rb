class PropertyManagersController < ApplicationController

  def new
    @house = House.find(params[:house_id])
    @manager = PropertyManager.new
  end

  def create
    @house = House.find(params[:house_id])
    @address = Address.new(address_params)
    if @address.save
      @manager = PropertyManager.new(property_manager_params)
      if @manager.save
        @house.update_attributes(property_manager_id: @manager.id)
        redirect_to house_path(@house)
      else
        render "new"
      end
    else
      render "new"
    end
  end

  private

  def property_manager_params
    params.require(:property_manager).permit(:name, :phone, :email)
  end

  def address_params
    params.require(:property_manager).require(:address).permit(:street, :city, :state, :zip_code)
  end

end
