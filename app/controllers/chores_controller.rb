module V1
  class ChoresController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index]

    def index
      @house = House.find(params[:house_id])
      @chores = @house.chores.order(created_at: :desc).all
      render json: @chores, each_serializer: ChoresSerializer
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
      @house = House.find(params[:house_id])
      @chore = @house.chores.new(chore_params)
      if @chore.save
        render json: @house.chores, serializer: ChoresSerializer
      else
        render json: { error: t('chore_create_error') }, status: :unprocessable_entity
      end
    end


    private

    def chore_params
      params.require(:chore).permit(:task)
    end
  end
end
