class IssuesController < ApplicationController

  def rule_issue_new
    @rule = Rule.find_by(id: params[:rule_id])
    @house = House.find_by(id: params[:house_id])
    @presenter = {
      :issues => @rule.issues,
      :users => User.all,
      :form => {
        :action => "/houses/#{@house.id}/rules/#{@rule.id}/issues/rule_issue_create",
        :csrf_param => request_forgery_protection_token,
        :csrf_token => form_authenticity_token
      }
    }
  end

  def rule_issue_create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @rule = Rule.find_by(id: params[:rule_id])
    @issue = @rule.issues.create(reason: params[:issue][:reason], user_id: @user.id)
    if request.xhr?
      render :json => @rule.issues
    else
      redirect_to house_rules_path(@house)
    end
  end

  def chore_issue_new
    @chore = Chore.find_by(id: params[:chore_id])
    @house = House.find_by(id: params[:house_id])
  end

  def chore_issue_create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = Chore.find_by(id: params[:chore_id])
    @issue = @chore.issues.create(reason: params[:issue][:task], user_id: @user.id)
    redirect_to house_chores_path(@house)
  end

  def item_issue_new
    @item = CommunalItem.find_by(id: params[:item_id])
    @house = House.find_by(id: params[:house_id])
  end

  def item_issue_create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @item = CommunalItem.find_by(id: params[:item_id])
    @issue = @item.issues.create(reason: params[:issue][:name], user_id: @user.id)
    redirect_to house_path(@house)
  end

  def event_issue_new
    @event = Event.find_by(id: params[:event_id])
    @house = House.find_by(id: params[:house_id])
  end

  def event_issue_create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @event = Event.find_by(id: params[:event_id])
    @issue = @event.issues.create(reason: params[:issue][:name], user_id: @user.id)
    redirect_to house_events_path(@house)
  end

end
