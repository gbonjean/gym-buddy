class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.owned_events.map(&:chatroom).reject { |c| c.event.bookings.select(&:accepted).map(&:user).empty? }
    @chatrooms << current_user.events.map(&:chatroom)
    @chatrooms = @chatrooms.flatten.sort_by(&:name)
    @counts = @messages_notifications.map(&:params).map { |p| p[:message] }.tally
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages_notifications.each { |n| n.destroy if n.params[:message] == @chatroom.id }
    @message = Message.new
  end
end
