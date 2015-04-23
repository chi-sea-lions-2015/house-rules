class ChoresController < ApplicationController

  def index
    @user = current_user
    @house = House.find(params[:house_id])
    @chores = @house.chores
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @chore_logs = @house.users.map {|user| user.chore_logs}
  end

  def edit
    @user = current_user
    @chore = Chore.find(params[:id])
    @house = @chore.house
    render :edit
  end


  def update

    chore = Chore.find(params[:id])
    chore.update_attributes(chore_params)
    @house = chore.house
    if chore.save!
      @notification = Notification.create(alert: "#{current_user.first_name} has updated a chore.")
      HousingAssignment.where(house_id: params[:house_id]).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
      redirect_to "/houses/#{@house.id}/chores"
    else
      flash.now[:error] = "chore did not save"
      redirect_to house_path(@house)
    end
  end

  def show
    @user = current_user
    @chore = Chore.find_by(id: params[:id])
    @house = @chore.house
    @chores = @house.chores
    @logged_users = @chore.chore_logs.map{|log| log.user_id }
    @logged_users.map!{|id| User.find(id)}
    render :show
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = @house.chores.new(chore_params)
    @users = @house.users
    if @chore.save
      @notification = Notification.create(alert: "#{current_user.first_name} has created a new chore.")
      HousingAssignment.where(house_id: params[:house_id]).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
      redirect_to "/houses/#{@house.id}/chores"
    else
      flash.now[:error] = "chore did not save"
      redirect_to house_path(@house)
    end
  end

  def destroy
    chore = Chore.find(params[:id])
    @house = chore.house
    @chore_logs = ChoreLog.where(chore_id: chore.id)
    @chore_logs.each{|log| log.destroy}
    params[:house_id] = @house.id
    chore.destroy
    @notification = Notification.create(alert: "#{current_user.first_name} has removed a chore.")
      HousingAssignment.where(house_id: params[:house_id]).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
    redirect_to "/houses/#{@house.id}/chores"
  end

  private

  def chore_params
    params.require(:chore).permit(:task)
  end

end
