class RulesController < ApplicationController

  def index
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id)
    @rules = @housing_assignment.rules
  end

  def create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @housing_assignment = HousingAssignment.find_by(house_id: @house.id, user_id: @user.id)
    @rule = @housing_assignment.rules.new(rule_params)
    if @rule.save
      redirect_to house_rules_path
    # else
    #   flash.now[:error] = "Rule did not save"
    #   redirect_to house_path(@house)
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
