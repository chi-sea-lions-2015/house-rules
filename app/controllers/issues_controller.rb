class IssuesController < ApplicationController

  def rule_issue_create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @rule = Rule.find_by(id: params[:rule_id])
    @issue = @rule.issues.create(reason: params[:issue][:reason], user_id: @user.id)
    if request.xhr?
      render partial: "communal_items/issue", locals: { issue: @issue }, layout: false
    else
      redirect_to house_rules_path(@house)
    end
  end

  def item_issue_create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @item = CommunalItem.find_by(id: params[:communal_item_id])
    @issue = @item.issues.create(reason: params[:issue][:reason], user_id: @user.id)
    if request.xhr?
      render partial: "communal_items/issue", locals: { issue: @issue }, layout: false
    else
      redirect_to house_communal_items_path(@house)
    end
  end

  def event_issue_create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @event = Event.find_by(id: params[:event_id])
    @issue = @event.issues.create(reason: params[:issue][:reason], user_id: @user.id) 
    if request.xhr?
      render partial: "events/issue", locals: { issue: @issue }, layout: false
    else
      redirect_to house_events_path(@house)
    end
  end

  def chore_issue_create
    @user = current_user
    @house = House.find_by(id: params[:house_id])
    @chore = Chore.find_by(id: params[:chore_id])
    @issue = @chore.issues.create(reason: params[:issue][:reason], user_id: @user.id)
    if request.xhr?
      render partial: "chores/issue", locals: { issue: @issue }, layout: false
    else
      redirect_to house_chores_path(@house)
    end
  end

end
