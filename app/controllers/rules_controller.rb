class RulesController < ApplicationController
skip_before_action :authenticate_user_from_token!

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
      puts "HEYYyYYyYYyyyyyyy"
      render @rule, layout: false
    else
      redirect_to house_events_path
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
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    if @rule.destroy
      redirect_to house_rules_path
    end
  end

  private

  def rule_params
    params.require(:rule).permit(:content)
  end
end
