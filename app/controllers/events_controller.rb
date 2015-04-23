class EventsController < ApplicationController
skip_before_action :authenticate_user_from_token!, only: [:index, :edit, :create]

  def create
    if @user = current_user
    @house = House.find_by(id: params[:house_id])
    @event = @house.events.new(event_params)
    @event.save
    @event.update_attributes(user_id: @user.id)
    @notification = Notification.create(alert: "#{current_user.first_name} has added a new event.")
      HousingAssignment.where(house_id: @house.id).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
    if request.xhr?
      render @event, layout: false
    else
      redirect_to house_events_path
    end
    else
      redirect_to login
    end
    # else
    #   flash.now[:error] = "Rule did not save"
    #   redirect_to house_path(@house)
  end

  def edit
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(event_params)
      @notification = Notification.create(alert: "#{current_user.first_name} has changed an event.")
      HousingAssignment.where(house_id: params[:house_id]).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
      redirect_to house_events_path
    end
  end

  def index
    @house = House.find_by(id: params[:house_id])
    @events = @house.events
    puts @events.last
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    if @event.destroy
      @notification = Notification.create(alert: "#{current_user.first_name} has removed an event.")
      HousingAssignment.where(house_id: params[:house_id]).select do |assignment|
        assignment.user.user_notifications.create(notification: @notification)
      end
      redirect_to house_events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :date, :name)
  end

end
