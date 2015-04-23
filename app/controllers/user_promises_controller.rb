class UserPromisesController < ApplicationController

	def create
		if @user = current_user
			@house = House.find_by(id: params[:house_id])
			@item = CommunalItem.find_by(id: params[:communal_item_id])
			@item.user_promise = UserPromise.create(user_id: @user.id)
				@notification = Notification.create(alert: "#{current_user.first_name} will get the next #{@item.name}.", category: "communal_items", house_id: @house.id)
	      HousingAssignment.where(house_id: @house.id).select do |assignment|
	        assignment.user.user_notifications.create(notification: @notification)
	      end
			redirect_to house_communal_items_path(@house)
		else
			redirect_to '/login'
		end
	end

	def update
		if @user = current_user
			@house = House.find_by(id: params[:house_id])
			@item = CommunalItem.find_by(id: params[:communal_item_id])
			@item.stock_level = "high"
			@item.save
			@promise = @item.user_promise
			@promise.destroy
				@notification = Notification.create(alert: "#{current_user.first_name} got #{@item.name} and it is in stock.", category: "communal_items", house_id: @house.id)
	      HousingAssignment.where(house_id: @house.id).select do |assignment|
	        assignment.user.user_notifications.create(notification: @notification)
	      end
			redirect_to house_communal_items_path(@house)
		else
			redirect_to '/login'
		end
	end

	def chore_promise_create
		@user = current_user
		@chore = Chore.find_by(id: params[:id])
		@house = @chore.house
		@promise = UserPromise.new(user_id: @user.id)
		if @promise.save!
			@chore.promise = @promise
				@notification = Notification.create(alert: "#{current_user.first_name} will #{@chore.task}.", category: "chores", house_id: @house.id)
	      HousingAssignment.where(house_id: @house.id).select do |assignment|
	        assignment.user.user_notifications.create(notification: @notification)
	      end
			redirect_to house_chores_path(@house)
		else
			flash.now[:error] = "promise did not save"
      redirect_to house_chores_patrailsh(@house)
    end
	end

	def chore_promise_update
		@user = current_user
		@chore = Chore.find_by(id: params[:id])
		@house = @chore.house
		@chore_log = @user.chore_logs.new(chore: @chore)
		if @chore_log.save!
			@promise = @chore.promise
				@notification = Notification.create(alert: "#{current_user.first_name} has completed #{@chore.task}.", category: "chores", house_id: @house.id)
	      HousingAssignment.where(house_id: @house.id).select do |assignment|
	        assignment.user.user_notifications.create(notification: @notification)
	      end
			@promise.destroy
			redirect_to house_chores_path(@house)
		else
			flash.now[:error] = "promise did not update"
      redirect_to house_chores_path(@house)
    end
	end

end
