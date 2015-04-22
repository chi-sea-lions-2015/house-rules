class CommunalItemsController < ApplicationController

  def index
    @house = House.find_by(id: params[:house_id])
    @presenter = {
      :items => @house.communal_items,
      :form => {
        :action => house_communal_items_path(@house),
        :csrf_param => request_forgery_protection_token,
        :csrf_token => form_authenticity_token
      }
    }
  end

  def new
    @house = House.find(params[:house_id])
    @item = CommunalItem.new
  end

  def create
    puts "^^^^^^^^^^"
    @house = House.find(params[:house_id])
    @item = @house.communal_items.create(item_params)
    if @item
      if request.xhr?
        render :json => @house.communal_items
      else
        redirect_to house_communal_items_path(@house)
      end
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
