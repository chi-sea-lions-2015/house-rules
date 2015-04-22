class MessagesController < ApplicationController

  def index
    @house = House.find(params[:house_id])
    @presenter = {
      :messages => Message.last(5),
      :form => {
        :action => house_messages_path(@house),
        :csrf_param => request_forgery_protection_token,
        :csrf_token => form_authenticity_token
      }
    }
  end

  def create
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @message = @housing_assignment.messages.new(message_params)
    if @message.save
      redirect_to house_messages_path(@house)
    else
      flash.now[:error] = "Message did not save"
      redirect_to house_path(@house)
    end
  end

  # def update
  #   @user = current_user
  #   @house = House.find_by(id: params[:house_id])
  #   @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
  #   @message = Message.find_by(id: params)
  # end

  def destroy
    @house = House.find_by(id: params[:house_id])
    @message = Message.find_by(id: params[:id])
    @message.destroy
    redirect_to house_messages_path(@house)
  end

private

    def message_params
      params.require(:message).permit(:content)
    end

end
