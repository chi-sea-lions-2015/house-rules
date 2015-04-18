class EventsController < ApplicationController

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @event = @housing_assignment.events.new(event_params)
    if @event.save
      redirect_to house_events_path
    # else
    #   flash.now[:error] = "Rule did not save"
    #   redirect_to house_path(@house)
    end
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
      redirect_to house_events_path
    end
  end

  def index
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id)
    @events = @housing_assignment.events
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    if @event.destroy
      redirect_to house_events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :date, :name)
  end

end
