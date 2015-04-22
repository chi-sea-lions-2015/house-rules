class ChoresController < ApplicationController

  def index
    @user = current_user
    @house = House.find(params[:house_id])
    @chores = @house.chores
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @chore_logs = @house.users.map {|user| user.chore_logs}
  end

  def update
    chore = Chore.find(params[:id])
    chore.task = params[:task]
    chore.save!
    render :nothing => true, :status => 200
  end

  def show
    @user = current_user
    @chore = Chore.find_by(id: params[:id])
    @house = @chore.house
    @chores = @house.chores
    @logged_users = @chore.chore_logs.map{|log| log.user_id }
    @logged_users.map!{|id| User.find(id)}
    render :show
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = @house.chores.new(chore_params)
    @users = @house.users
    if @chore.save
      redirect_to house_chores_path
    else
      flash.now[:error] = "chore did not save"
      redirect_to house_path(@house)
    end
  end

  def destroy
    chore = Chore.find(params[:id])
    chore.destroy
    render :nothing => true, :status => 200
  end

  private

  def chore_params
    params.require(:chore).permit(:task)
  end

end
