# module V1
  class EventsController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index]

    def index
      @house = House.find(params[:house_id])
      @events = @house.events.all
      render json: @events, each_serializer: EventSerializer
    end

    def create
      @user = current_user
      @house = House.find(params[:house_id])

      @event = @house.events.new(event_params)
      @event.update_attributes(creator: @user.first_name)

      if @event.save
        render json: @event, each_serializer: EventSerializer
      else
        render json: { error: t('event_create_error') }, status: :unprocessable_entity
      end
    end

    def update
      @event = Event.find(params[:id])
      @event.update_attributes(event_params)
      @event.save!
      render :nothing => true, :status => 200
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      render :nothing => true, :status => 200
    end

    private

    def event_params
      params.require(:event).permit(:description, :date, :name)
    end
  end
# end
