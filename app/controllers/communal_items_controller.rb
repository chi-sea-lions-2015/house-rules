class CommunalItemsController < ApplicationController

  def new
    @house = House.find(params[:house_id])
    @item = CommunalItem.new
  end

  def create
    @house = House.find(params[:house_id])
    @item = @house.communal_items.create(item_params)
    if @item
      redirect_to house_path(@house)
    else
      render 'new'
    end
  end

  def edit
    @house = House.find(params[:house_id])
    @item = CommunalItem.find(params[:id])
  end

  def update
    @house = House.find(params[:house_id])
    @item = CommunalItem.find(params[:id])
    @item.update(item_params)
    redirect_to house_path(@house)
  end

  def destroy
    @house = House.find(params[:house_id])
    @item = CommunalItem.find(params[:id])
    @item.destroy
    redirect_to house_path(@house)
  end

  private

  def item_params
    params.require(:communal_item).permit(:name, :brand, :quantity, :stock_level)
  end

end
