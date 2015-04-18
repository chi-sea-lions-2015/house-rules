class ChoreLogsController < ApplicationController

  def index
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = Chore.find_by(id: params[:chore_id])
    @chore_logs = @house.users.map {|user| user.chore_logs}
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = Chore.find_by(id: params[:chore_id])
    @chore_log = @user.chore_logs.new(chore: @chore)
    if @chore_log.save
      redirect_to house_chore_chore_logs_path
    end
  end

  def destroy
    @chore_log = ChoreLog.find_by(id: params[:id])
    if @chore_log.destroy
      redirect_to house_chore_chore_logs_path
    end
  end
end
