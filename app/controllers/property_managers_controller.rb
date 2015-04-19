module V1
  class PropertyManagersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index]

    def create
      @house = House.find(params[:house_id])
      @address = Address.new(address_params)
      if @address.save
        @manager = PropertyManager.new(property_manager_params)
        if @manager.save
          @house.update_attributes(property_manager_id: @manager.id)
          @address.update_attributes(addressable_type: "PropertyManager", addressable_id: @manager.id)
          render json: @house, serializer: HouseSerializer
        else
          render json: { error: t('property_manager_create_error') }, status: :unprocessable_entity
        end
      end
    end

    def update
      @house = House.find(params[:house_id])
      @manager = PropertyManager.find(params[:id])
      @manager.update_attributes(property_manager_params)
      @address = @manager.address
      @address.update_attributes(address_params)
      render :nothing => true, :status => 200
    end

    private

    def property_manager_params
      params.require(:property_manager).permit(:name, :phone, :email)
    end

    def address_params
      params.require(:property_manager).require(:address).permit(:street, :city, :state, :zip_code)
    end
  end
end
