class ChoresController < ApplicationController

  def index
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chores = @house.chores
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = @house.chores.new(chore_params)
    if @chore.save
      redirect_to house_chores_path
    else
      flash.now[:error] = "chore did not save"
      redirect_to house_path(@house)
    end
  end

  def edit
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = Chore.find_by(id: params[:id])
  end

  def update
    @chore = Chore.find_by(id: params[:id])
    if @chore.update_attributes(chore_params)
      redirect_to house_chores_path
    end
  end

  def destroy
    @chore = Chore.find_by(id: params[:id])
    if @chore.destroy
      redirect_to house_chores_path
    end
  end

  private

  def chore_params
    params.require(:chore).permit(:task)
  end


end
