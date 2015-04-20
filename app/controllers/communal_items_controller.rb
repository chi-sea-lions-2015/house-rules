# module V1
  class CommunalItemsController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index]

    def index
      @house = House.find(params[:house_id])
      @communal_items = @house.communal_items.order(created_at: :desc).all
      render json: @communal_items, each_serializer: CommunalItemsSerializer
    end

    def create
      @house = House.find(params[:house_id])
      @communal_items = @house.communal_items.order(created_at: :desc).all

      @item = @house.communal_items.new(item_params)
      if @item.save
        render json: @item, each_serializer: CommunalItemsSerializer
      else
        render json: { error: t('item_create_error') }, status: :unprocessable_entity
      end
    end

    def update
      @item = CommunalItem.find(params[:id])
      @item.update_attributes(item_params)
      @item.save!
      render :nothing => true, :status => 200
    end

    def destroy
      @item = CommunalItem.find(params[:id])
      @item.destroy
      render :nothing => true, :status => 200
    end

    private

    def item_params
      params.require(:communal_item).permit(:name, :brand, :quantity, :stock_level)
    end
  end
# end
