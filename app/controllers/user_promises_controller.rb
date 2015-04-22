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

	def chore_promise_create
		@user = current_user
		@chore = Chore.find_by(id: params[:id])
		@house = @chore.house
		@promise = UserPromise.new(user_id: @user.id)
		if @promise.save!
			@chore.promise = @promise
			redirect_to house_chores_path(@house)
		else
			flash.now[:error] = "promise did not save"
      redirect_to house_chores_path(@house)
    end
	end

	def chore_promise_update
		@user = current_user
		@chore = Chore.find_by(id: params[:id])
		@house = @chore.house
		@chore_log = @user.chore_logs.new(chore: @chore)
		if @chore_log.save!
			@promise = @chore.promise
			@promise.destroy
			redirect_to house_chores_path(@house)
		else
			flash.now[:error] = "promise did not update"
      redirect_to house_chores_path(@house)
    end
	end

end
