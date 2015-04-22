class UserPromisesController < ApplicationController

def create
	@user = current_user
	@house = House.find_by(id: params[:house_id])
	@item = Item.find_by(id: params[:communal_item_id])
	@promise = @item.user_promises.create(user_id: @user.id)
	if request.xhr?
		render :json => @user
	else
		redirect_to house_communal_items_path(
			@house)
	end
end

end
