class EventsController < ApplicationController

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @event = @housing_assignment.events.new(event_params)
    @event.save
    if request.xhr?
      render :json => @house.events
    else
      redirect_to house_events_path(@house)
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
    @house = House.find_by(id: params[:house_id])
    @presenter = {
      :events => @house.events,
      :form => {
        :action => house_events_path(@house),
        :csrf_param => request_forgery_protection_token,
        :csrf_token => form_authenticity_token
      }
    }
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
