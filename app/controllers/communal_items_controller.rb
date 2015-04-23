class CommunalItemsController < ApplicationController

  def index
    @user = current_user
    @house = House.find(params[:house_id])
    @items = @house.communal_items
    @stock_levels = ["high","low","out"]
    @items_by_level = @items.all.group_by(&:stock_level)
  end

  def create
    @house = House.find(params[:house_id])
    @item = @house.communal_items.create(item_params)
    if @item

      redirect_to house_communal_items_path(@house)

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
    redirect_to house_communal_items_path(@house)
  end

  def destroy
    @house = House.find(params[:house_id])
    @item = CommunalItem.find(params[:id])
    @item.destroy
    redirect_to house_communal_items_path(@house)
  end

  def high
    @house = House.find(params[:house_id])
    @item = CommunalItem.find(params[:id])
    @item.stock_level = "high"
    @item.save
    @user_promise = @item.user_promise
    if @user_promise
      @user_promise.destroy
    end
    redirect_to house_communal_items_path(@house)
  end

  def low
    @house = House.find(params[:house_id])
    @item = CommunalItem.find(params[:id])
    @item.stock_level = "low"
    @item.save
    redirect_to house_communal_items_path(@house)
  end

  def out
    @house = House.find(params[:house_id])
    @item = CommunalItem.find(params[:id])
    @item.stock_level = "out"
    @item.save
    redirect_to house_communal_items_path(@house)
  end

  private

  def item_params
    params.require(:communal_item).permit(:name, :brand, :quantity, :stock_level)
  end

end
