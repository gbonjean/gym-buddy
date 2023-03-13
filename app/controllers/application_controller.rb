class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_notifications

  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user)
    @answers_notifications = @notifications.select { |n| n.params[:answer] && n.unread? }
    @asks_notifications = @notifications.select { |n| n.params[:ask] && n.unread? }
    @messages_notifications = @notifications.select { |n| n.params[:message] && n.unread? }
    @index_count = @asks_notifications.count + @answers_notifications.count
  end
end
