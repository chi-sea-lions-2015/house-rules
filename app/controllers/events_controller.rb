class EventsController < ApplicationController
skip_before_action :authenticate_user_from_token!, only: [:index, :edit, :create]

  def index
    @house = House.find_by(id: params[:house_id])
    @events = @house.events.order('date desc')
    @events_by_date = @events.all.group_by(&:date)
    puts "^^^^^^^^^^^^^"
    puts @events_by_date
    @today = Date.today
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @event = @house.events.new(event_params)
    @event.save
    @event.update_attributes(user_id: @user.id)
    redirect_to house_events_path(@house)
  end

  def edit
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @event = Event.find_by(id: params[:id])
  end

  def update
    if @user = current_user
      @event = Event.find_by(id: params[:id])
      if @event.update_attributes(event_params)
        redirect_to house_events_path(@house)
      end
    else
      redirect_to '/login'
    end
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
