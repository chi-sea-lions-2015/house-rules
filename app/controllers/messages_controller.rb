class MessagesController < ApplicationController

  # def index
  #   @user = current_user
  #   @house = House.find_by(id: params[:id])
  #   @housing_assignment = HousingAssignment.where(house_id: @house.id)
  #   @messages = @housing_assignment.map do |h_a|
  #     h_a.messages
  #   end
  # end

  def new
    @user = current_user
    @house = House.find_by(id: params[:id])
    @housing_assignment = HousingAssignment.where(house_id: @house.id)
  end
#DO NOT ERASE DO NOT COMMENT OUT==============
  def index
    @house = House.find(params[:house_id])
    @messages = @house.messages
  end
#============================
  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @message = @housing_assignment.messages.new(message_params)
    if @message.save
      redirect_to house_path(@house)
    # else
    #   flash.now[:error] = "Message did not save"
    #   redirect_to house_path(@house)
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
      params.require(:message).permit(:content, :picture_url)
    end

end
