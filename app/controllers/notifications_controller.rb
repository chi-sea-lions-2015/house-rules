class NotificationsController < ApplicationController

  def index
    @user = current_user
    @user_notifications = current_user.user_notifications.pluck(:notification_id)
    @notifications = []
    @user_notifications.each do |notify|
      @notifications << Notification.find(notify)
    end
  end

end
