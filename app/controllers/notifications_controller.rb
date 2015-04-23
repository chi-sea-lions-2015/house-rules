class NotificationsController < ApplicationController


  def destroy
      @house = current_user.houses.first
      @notification = Notification.find(params[:id])
      @user_notification = UserNotification.find_by(notification_id: @notification.id)
      @user_notification.destroy
      @notification.destroy
      redirect_to "/houses/#{@house.id}/#{@notification.category}"
  end
end
