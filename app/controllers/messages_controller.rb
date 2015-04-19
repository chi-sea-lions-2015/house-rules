module V1
  class MessagesController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index]

    def index
      @house = House.find(params[:house_id])
      @messages = Message.where(house_id: @house.id)
      render json: @messages, each_serializer: MessagesSerializer
    end

    def create
      @house = House.find(params[:house_id])
      @messages = Message.where(house_id: @house.id)

      @message = @house.messages.new(message_params)
      @message.update_attributes(author: current_user)

      if @message.save
        render :json => @messages, each_serializer: MessagesSerializer
      else
        render json: { error: t('message_create_error') }, status: :unprocessable_entity
      end
    end

    def destroy
      @message = Message.find(params[:id])
      @message.destroy
      render :nothing => true, :status => 200
    end

    private

    def message_params
      params.require(:message).permit(:content).merge(author: current_user)
    end
  end
end
