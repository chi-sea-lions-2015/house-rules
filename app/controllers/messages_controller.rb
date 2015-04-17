class MessagesController < ApplicationController

  def index
    @user = current_user
    @house = House.find_by(id: params[:id])
    @housing_assignment = HousingAssignment.where()
    @messages = @house.housing_assignment
  end

  def new
    @user = current_user
  end

  def create
    @user = current_user
    @housing_assignment = HousingAssignment
    @message
  end

  def update
    @user = current_user
  end

  def destroy
  end

end
