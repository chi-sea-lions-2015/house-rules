# module V1
  class CommunalItemsController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :create]

    def index
      @house = House.find(params[:house_id])
      @communal_items = @house.communal_items.order(created_at: :desc).all
      puts @communal_items
      render json: @communal_items, each_serializer: CommunalItemSerializer
    end

    def create
      @house = House.find(params[:house_id])
      @communal_items = @house.communal_items.order(created_at: :desc).all

      @item = @house.communal_items.create(item_params)
      @items = @house.communal_items
      if @item
        render json: @items, each_serializer: CommunalItemsSerializer
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
