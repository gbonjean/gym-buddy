class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_notifications
  around_action :switch_locale

  private

  def set_notifications
    if user_signed_in?
      @answers_notifications = current_user.answers_notifications
      @answers = current_user.answers
      @asks_notifications = current_user.asks_notifications
      @asks = current_user.asks
      @messages_notifications = current_user.messages_notifications
      @messages = current_user.messages
      @index_count = @asks.count + @answers.count
    end
  end

  def switch_locale(&action)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
