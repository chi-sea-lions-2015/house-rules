class ChoresController < ApplicationController

  def index
    @chores = Chore.select("id, task").to_json
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
end
