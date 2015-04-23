class ChoresController < ApplicationController

  def index
    @user = current_user
    @house = House.find(params[:house_id])
    @chores = @house.chores
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @chore_logs = @house.users.map {|user| user.chore_logs}
  end

  def edit
    @user = current_user
    @chore = Chore.find(params[:id])
    @house = @chore.house
    render :edit
  end


  def update
    if @user = current_user
      chore = Chore.find(params[:id])
      chore.update_attributes(chore_params)
      @house = chore.house
      if chore.save!
        redirect_to "/houses/#{@house.id}/chores"
      else
        flash.now[:error] = "chore did not save"
        redirect_to house_path(@house)
      end
    else
      redirect_to '/login'
    end
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
    if @user = current_user
      @house = House.find_by(id: params[:house_id])
      @chore = @house.chores.new(chore_params)
      @users = @house.users
      if @chore.save
        redirect_to "/houses/#{@house.id}/chores"
      else
        flash.now[:error] = "chore did not save"
        redirect_to house_path(@house)
      end
    else
      redirect_to '/login'
    end
  end

  def destroy
    if @user = current_user
      chore = Chore.find(params[:id])
      @house = chore.house
      @chore_logs = ChoreLog.where(chore_id: chore.id)
      @chore_logs.each{|log| log.destroy}
      params[:house_id] = @house.id
      chore.destroy
      redirect_to "/houses/#{@house.id}/chores"
    else
      redirect_to '/login'
    end
  end

  private

  def chore_params
    params.require(:chore).permit(:task)
  end

end
