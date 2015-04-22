class RulesController < ApplicationController

  def index
    @house = House.find_by(id: params[:house_id])
    @rules = @house.rules
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @rule = @house.rules.new(rule_params)
    @rule.save
    if request.xhr?
      render :json => @house.rules
    else
      flash.now[:error] = "Rule did not save"
      redirect_to house_path(@house)
    end
  end

  def edit
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @rule = Rule.find_by(id: params[:id])
  end

  def update
    @rule = Rule.find_by(id: params[:id])
    if @rule.update_attributes(rule_params)
      redirect_to house_rules_path
    end
  end

  def destroy
    @rule = Rule.find_by(id: params[:id])
    if @rule.destroy
      redirect_to house_rules_path
    end
  end

  private

  def rule_params
    params.require(:rule).permit(:content)
  end
end
