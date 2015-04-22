class UserPromisesController < ApplicationController


	def create 
		@user = current_user
		@house = House.find_by(id: params[:house_id])
		@item = CommunalItem.find_by(id: params[:communal_item_id])
		@item.user_promise = UserPromise.create(user_id: @user.id)
		redirect_to house_communal_items_path(@house)
	end

	def update
		@house = House.find_by(id: params[:house_id])
		@item = CommunalItem.find_by(id: params[:communal_item_id])
		@item.stock_level = "high"
		@item.save
		@promise = @item.user_promise
		@promise.destroy
		redirect_to house_communal_items_path(@house)
	end

end
