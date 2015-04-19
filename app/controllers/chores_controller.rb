class ChoresController < ApplicationController

  def index
    # @chores = Chore.select("id, task").to_json
    @house = House.find(params[:house_id])
    puts @house.id
    @presenter = {
      :chores => @house.chores,
      :form => {
        :action => house_chores_path(@house),
        :csrf_param => request_forgery_protection_token,
        :csrf_token => form_authenticity_token
      }
    }
  end

  def update
    chore = Chore.find(params[:id])
    chore.task = params[:task]
    chore.save!
    render :nothing => true, :status => 200
  end

  def destroy
    chore = Chore.find(params[:id])
    chore.destroy
    render :nothing => true, :status => 200
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = @house.chores.new(chore_params)
    @chore.save
    if request.xhr?
      render :json => @house.chores
    else
      redirect_to house_chores_path
    end
  end


  private

  def chore_params
    params.require(:chore).permit(:task)
  end

end
