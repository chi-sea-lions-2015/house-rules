module V1
  class ChoreLogsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    # def index
    #   @house = House.find_by(id: params[:house_id])
    #   @chore = Chore.find_by(id: params[:chore_id])
    #   @chore_logs = @house.users.map {|user| user.chore_logs}
    # end

    def create
      @user = current_user
      @chore = Chore.find(params[:chore_id])
      @chore_log = @user.chore_logs.new(chore: @chore)

      if @chore_log.save
        render json: @chore_log, serializer: ChoreLogSerializer
      else
        render json: { error: t('chore_log_create_error') }, status: :unprocessable_entity
      end
    end

    def destroy
      @chore_log = ChoreLog.find(params[:id])
      @chore_log.destroy
      render :nothing => true, :status => 200
    end
  end
end
