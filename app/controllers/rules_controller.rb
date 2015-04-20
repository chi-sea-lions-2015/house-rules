class RulesController < ApplicationController
 skip_before_action :authenticate_user_from_token!, only: [:index, :create]

  def index
    @house = House.find(params[:house_id])
    @rules = @house.rules.order(created_at: :desc).all
    render :json => @rules, each_serializer: RulesSerializer
  end

  def create
    @house = House.find(params[:house_id])
    @rules = @house.rules.order(created_at: :desc).all

    @rule = @house.rules.new(rule_params)
    if @rule.save
      render json: @rules, each_serializer: RulesSerializer
    else
      render json: { error: t('rule_create_error') }, status: :unprocessable_entity
    end
  end

  def update
    @rule = Rule.find(params[:id])
    @rule.update_attributes(rule_params)
    render :nothing => true, :status => 200
  end

  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy
    render :nothing => true, :status => 200
  end

  private

  def rule_params
    params.require(:rule).permit(:content)
  end
end
