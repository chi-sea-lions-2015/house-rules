class MessagesController < ApplicationController

  def index
    @user = current_user
    @house = House.find_by(id: params[:id])
    @housing_assignment = HousingAssignment.where(house_id: @house.id)
    @messages = @housing_assignment.map do |h_a| 
      h_a.messages 
    end
  end

  def new
    @user = current_user
    @house = House.find_by(id: params[:id])
    @housing_assignment = HousingAssignment.where(house_id: @house.id)
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @message = @user.messages.new(params[:message])
    if @message.save
      redirect "index"
    else
      flash.now[:error] = "Message did not save"
      redirect "index"
     end
   end

  def update
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @message = Message.find_by(id: params)
  end

  def destroy
  end

private

    def message_params
      params.require(:message).permit(:content, :picture_url)
    end

end
