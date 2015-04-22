class MessagesController < ApplicationController

  def new
    @user = current_user
    @house = House.find_by(id: params[:id])
    @housing_assignment = HousingAssignment.where(house_id: @house.id)
  end

  def index
    @house = House.find(params[:house_id])
    @messages = @house.messages
  end

  def create
    @house = House.find(params[:house_id])
    @message = @house.messages.new(message_params)
    @message.update_attributes(author: current_user)
    if (params[:message][:picture])
      @picture = Picture.new(picture_content: params[:message][:picture][:picture_content], message_id: @message.id)
      if @picture.save
        if @message.save
          redirect_to house_messages_path(@house)
        else
          flash.now[:error] = "Message did not save"
          redirect_to house_messages_path(@house)
        end
      else
          flash.now[:error] = "Picture did not save"
          redirect_to house_messages_path(@house)
      end
    else
      if @message.save
        redirect_to house_messages_path(@house)
      else
        flash.now[:error] = "Message did not save"
        redirect_to house_messages_path(@house)
      end
    end
  end

  def destroy
    @house = House.find(params[:house_id])
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to house_messages_path(@house)
  end

private

    def message_params
      params.require(:message).permit(:content)
    end

end
