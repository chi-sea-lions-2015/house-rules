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
    @message = @house.messages.new(message_params)
    @message.save

      if request.xhr?
        render :json => Message.last(5)
      else
      redirect_to house_messages_path(@house)
      end
   end

  # def update
  #   @user = current_user
  #   @house = House.find_by(id: params[:house_id])
  #   @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
  #   @message = Message.find_by(id: params)
  # end

  def destroy
  end

private

    def message_params
      params.require(:message).permit(:content)
    end

end
