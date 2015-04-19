class MessagesController < ApplicationController

  def index
    @house = House.find(params[:house_id])
      :messages => Message.where(house_id: @house.id).includes(:author),
      render json: @stories, each_serializer: MessagesSerializer
  end

  def create
    @house = House.find_by(id: params[:house_id])
    @message = @house.messages.new(message_params)
    @message.update_attributes(author: current_user)

      if @message.save
        render :json => @message, serializer: MessageSerializer
      else
        render json: { error: t('message_create_error') }, status: :unprocessable_entity
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
    redirect_to house_path(@house)
  end

private

    def message_params
      params.require(:message).permit(:content).merge(author: current_user)
    end

end
