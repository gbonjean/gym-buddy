class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_notifications
  around_action :switch_locale

  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user)
    @answers_notifications = @notifications.select { |n| n.params[:answer] && n.unread? }
    @answers = @answers_notifications.map { |n| n.params[:answer] }
    @asks_notifications = @notifications.select { |n| n.params[:ask] && n.unread? }
    @asks = @asks_notifications.map { |n| n.params[:ask] }
    @messages_notifications = @notifications.select { |n| n.params[:message] && n.unread? }
    @messages = @messages_notifications.map { |n| n.params[:message] }
    @index_count = @asks_notifications.count + @answers_notifications.count
  end

  def switch_locale(&action)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
