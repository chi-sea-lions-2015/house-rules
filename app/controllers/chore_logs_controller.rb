class ChoreLogsController < ApplicationController

  # def index
  #   @user = current_user
  #   @house = House.find_by(id: params[:house_id])
  #   @users = @house.users
  #   @chores = @house.chores
  #   @chore = Chore.find_by(id: params[:chore_id])
  #   @chore_logs = @house.users.map {|user| user.chore_logs}

  # end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = Chore.find_by(id: params[:chore_id])
    @chore_log = @user.chore_logs.new(chore: @chore)
    @chores = @house.chores
    if @chore_log.save
      redirect_to house_chores_path
    end
  end

  def destroy
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chores = @house.chores
    @chore_log = ChoreLog.find_by(id: params[:id])
    if @chore_log.destroy
      redirect_to house_chores_path
    end
  end
end
