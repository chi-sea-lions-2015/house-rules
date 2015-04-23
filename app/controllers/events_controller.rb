class EventsController < ApplicationController
skip_before_action :authenticate_user_from_token!, only: [:index, :edit, :create]

  def create
    if @user = current_user
    @house = House.find_by(id: params[:house_id])
    @event = @house.events.new(event_params)
    @event.save
    @event.update_attributes(user_id: @user.id)
    if request.xhr?
      puts "HEYYyYYyYYyyyyyyy"
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
      redirect_to house_events_path
    end
  end

  def index
    @house = House.find_by(id: params[:house_id])
    @events = @house.events
    puts @events.last
    puts "***********************"
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
