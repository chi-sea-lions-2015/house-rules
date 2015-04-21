# module V1
  class MessagesController < ApplicationController


    def index
      @house = House.find(params[:house_id])
      @messages = Message.where(house_id: @house.id)
      render json: @messages, each_serializer: MessagesSerializer
    end


  def create
    @house = House.find(params[:house_id])
    @user = current_user

    @message = @house.messages.new(message_params)
    @message.update_attributes(author: @user.first_name)

    if @message.save
      render json: @message, each_serializer: MessagesSerializer

    else
      warden.custom_failure!
      render json: {error: t('sessions_controller.invalid_login_attempt')}, status: :unprocessable_entity
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
# end
